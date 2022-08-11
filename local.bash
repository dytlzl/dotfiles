#!/usr/bin/env bash

export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,hl+:#bd93f9 --color=info:#ffb86c,prompt:#8e71d4,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export BAT_THEME="Dracula"

. ~/ghq/github.com/lincheney/fzf-tab-completion/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

_fzf_ghq_list() {
  local path=$(ghq list -p | fzf --reverse --preview 'batcat --color=always {}/README.md')
  if [[ -z $path ]]; then
    return 1
  fi
  READLINE_LINE="cd $path"
  READLINE_POINT=${#READLINE_LINE}
}

bind -x '"\201": _fzf_ghq_list'
bind '"\C-g": "\201\C-m"'

_fzf_find() {
  local path=$(find * -type f -not -path '*/\.git/*' | fzf --reverse --preview 'batcat --color=always {}')
  if [[ -z $path ]]; then
    return 0
  fi
  vi $path
}

bind -x '"\C-f": _fzf_find'

_fzf_history() {
  READLINE_LINE=$(HISTTIMEFORMAT='' history | sort -k1,1nr | sed -e 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | awk '!x[$0]++' | fzf --height '30%' --reverse --query "$READLINE_LINE")
  READLINE_POINT=${#READLINE_LINE}
}

bind -x '"\C-r": _fzf_history'

fzfrg() {
  vi $(__fzf_ripgrep)
}

__fzf_ripgrep() {
  rg_cmd="rg --smart-case --line-number --color=always --trim"
  selected=$(FZF_DEFAULT_COMMAND=":" \
      fzf --bind="change:top+reload($rg_cmd {q} || true)" \
          --bind="ctrl-l:execute(tmux splitw -h -- nvim +/{q} {1} +{2})" \
          --ansi --phony \
          --delimiter=":" \
          --reverse \
          --preview="batcat -H {2} --color=always --style=header,grid {1}")

  local ret=$?
  local list=(${selected//:/ })
  [[ -n "$selected" ]] && echo ${list[0]}
  return $ret
}

bind -x '"\C-?\C-r\C-g": _fzf_rg'

gd() {
  if ! files=$(git diff $1 --name-only); then
    return 1
  fi
  if [[ -z $files ]]; then
    echo "No differences."
    return 0
  fi
  local filename=$(echo -e "$files" | fzf --reverse --preview-window down,70% --preview 'git diff --no-prefix -U1000 '$1' -- {} | delta -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}')
  if [[ -z $filename ]]; then
    echo "No item selected."
    return 0
  fi
  git diff --no-prefix -U1000 $1 -- $filename | delta
}

_complete_gd() {
  if ! git status >/dev/null 2>&1; then
    return 0
  fi
  COMPREPLY=(HEAD HEAD^)
  local branch
  for branch in $(git branch -l | awk '{print substr($0, 3)}'); do
    COMPREPLY+=("$branch")
  done
}

complete -F _complete_gd gd

_parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit"* ]] && echo "*"
}

_parse_git_branch() {
  local branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \1$(_parse_git_dirty)/")
  [[ -n $branch ]] && echo -e "on \033[38;5;200m$branch"
}

PS1='\[\033[38;5;141m\]\w\[\033[0m\] $(_parse_git_branch)\n\[\033[38;5;141m\]\\$\[\033[0m\] '

alias mk='bash ./__ignore.mk.sh'
alias vimk='vi ./__ignore.mk.sh'

