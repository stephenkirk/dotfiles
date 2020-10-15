set number
set wildmenu
syntax on
set clipboard=unnamed " For sharing clipboard with the system
set scrolloff=2         " 2 lines above/below cursor when scrolling
set hlsearch
set autoindent          " Copy the same indent from the previous line
set ignorecase smartcase
set incsearch
set showmode
set linebreak

" infinite persistent undo
set undofile
set undodir=~/.vim/undodir

" Remove highlights with <Ctrl-l>
nnoremap <silent> <C-l> :nohl<CR><C-l> 

" Space as leader key
let mapleader=" "

" Bindings
nnoremap <silent> <Leader>s :split<CR>
nnoremap <silent> <Leader>v :vsplit<CR>
nnoremap <silent> <Leader>q :close<CR>

" Commands
command! Jsonformat :%!python -m json.tool

" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'dense-analysis/ale'
if (has('nvim'))
	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif
call plug#end()

