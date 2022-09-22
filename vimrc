if &compatible
  set nocompatible
endif

" vim-jetpack
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/jetpack.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/jetpack.vim --create-dirs  https://raw.githubusercontent.com/tani/vim-jetpack/main/plugin/jetpack.vim'
  autocmd VimEnter * JetpackSync | source $MYVIMRC
endif
call jetpack#begin()
Jetpack 'junegunn/fzf.vim'
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
Jetpack 'vlime/vlime', { 'rtp': 'vim' }
Jetpack 'dracula/vim', { 'as': 'dracula' }
Jetpack 'scrooloose/nerdtree'
Jetpack 'Xuyuanp/nerdtree-git-plugin'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'tpope/vim-fugitive'
Jetpack 'fatih/vim-go', { 'for': 'go' }
Jetpack 'rust-lang/rust.vim', { 'for': 'rust' }
Jetpack 'vim-airline/vim-airline'
Jetpack 'vim-airline/vim-airline-themes'
Jetpack 'liuchengxu/space-vim-dark'
Jetpack 'ryanoasis/vim-devicons'
for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor
call jetpack#end()

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='violet'

" coc.nvim
let g:coc_global_extensions = [
  \'coc-go',
  \'coc-rust-analyzer',
  \'coc-pyright',
  \'coc-json',
  \'coc-markdownlint',
  \'coc-yaml'
\]
nmap <silent> <space><space> :<C-u>CocList<cr>
nmap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
nmap <silent> <space>d <Plug>(coc-definition)
nmap <silent> <space>rf <Plug>(coc-references)
nmap <silent> <space>rn <Plug>(coc-rename)
nmap <silent> <space>fmt <Plug>(coc-format)

" rust-lang
let g:rustfmt_autosave = 1

" vim-go
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode = 2
let g:NERDTreeGitStatusUseNerdFonts = 1

" gitgutter
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=blue

" space-vim-dark
" colorscheme space-vim-dark

" dracula
colorscheme dracula

" fzf.vim
map <C-f> :Files<CR>
map <C-r><C-g> :Rg<CR>
map <C-g> :GFiles?<CR>

" *******************************************************
" Basic
" *******************************************************

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,shift_jis

set updatetime=300

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

autocmd FileType * setlocal formatoptions-=ro

syntax enable

set number
set ruler
set wildmenu
set showmatch
set list
set listchars=tab:>-,extends:<,trail:-
set laststatus=2
highlight SpecialKey ctermfg=239
highlight LineNr ctermfg=239
highlight VertSplit cterm=none
highlight Normal guibg=NONE ctermbg=NONE

set autoindent
set expandtab

" Enable mouse
set mouse=a
set ttymouse=xterm2

set shiftwidth=2
set tabstop=2
set softtabstop=2

set wrap
set whichwrap=h,l,b,s,<,>,[,]
set backspace=indent,eol,start
set title

" Copy/Paste/Cut
set clipboard&
set clipboard^=unnamed,unnamedplus

" Golang
au FileType go setlocal sw=4 ts=4 sts=4 noet

" Python
au FileType python setlocal sw=4 ts=4 sts=4 et

" Makefile
au FileType make setlocal sw=4 ts=4 sts=4 noet

map <C-@> :bo term ++rows=20<CR>

" Persist undo
if has('persistent_undo')
  silent execute '!mkdir -p ~/.vim/undo'
  set undodir=~/.vim/undo
  set undofile
endif

