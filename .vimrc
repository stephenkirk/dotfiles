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

" Plugins
call plug#begin()
Plug 'dense-analysis/ale'
call plug#end()
