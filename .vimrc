if &compatible
  set nocompatible
endif

" vim-jetpack
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/jetpack.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/jetpack.vim --create-dirs  https://raw.githubusercontent.com/tani/vim-jetpack/master/autoload/jetpack.vim'
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
highlight SpecialKey ctermfg=92
highlight LineNr ctermfg=92
highlight VertSplit cterm=none

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
set clipboard=unnamed

" Golang
au FileType go setlocal sw=4 ts=4 sts=4 noet

" Makefile
let _curfile=expand("%:r")
if _curfile == 'Makefile'
  set noexpandtab
endif
