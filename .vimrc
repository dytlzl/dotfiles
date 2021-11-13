if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

 
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')


  call dein#load_toml('~/.vim/dein/plugins.toml', {'lazy': 0})
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


" *******************************************************
" Basic
" *******************************************************

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,shift_jis

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
highlight SpecialKey ctermfg=92
highlight LineNr ctermfg=240

set autoindent
set expandtab

" Enable mouse
set mouse=a
set ttymouse=xterm2

set shiftwidth=4
set tabstop=4
set softtabstop=4

set wrap
set whichwrap=h,l,b,s,<,>,[,]
set backspace=indent,eol,start
set title

" Copy/Paste/Cut
set clipboard=unnamed,autoselect


" Golang
au FileType go setlocal sw=4 ts=4 sts=4 noet

