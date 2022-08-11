#!/usr/bin/env bash

targets="local.bash vimrc tmux.conf"

_diff() {
  if [[ -n "$(which colordiff)" ]]; then
    colordiff -uN $@
  else
    diff -uN $@
  fi
  return 0
}

install() {
  local target
  local diff_to_apply=$(showdiff)
  if [[ -z "$diff_to_apply" ]]; then
    echo "No changes to apply."
    return 0
  fi
  echo "$diff_to_apply"
  echo
  echo -n "Are you sure you want to apply the above changes? (y/n): "
  local response
  read response
  if [[ $response != "y" ]]; then
    echo "Cancelled."
    return 0
  fi
  for target in $targets; do
    local dest="$HOME/.$target"
    echo "Copy '$target' to '$dest'..."
    cp $target $dest
  done
  echo "Finished."
  exec -l $SHELL
}

showdiff() {
  local target
  for target in $targets; do
    local dest="$HOME/.$target"
    _diff $dest $target
  done
}

$@
