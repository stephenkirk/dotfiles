set number
set wildmenu " For file switching with :b
syntax on
set clipboard=unnamed " For sharing clipboard with the system
set scrolloff=2         " 2 lines above/below cursor when scrolling
set hlsearch
set autoindent          " Copy the same indent from the previous line
set ignorecase smartcase
set incsearch
set showmode

" minimum nr. of lines above and below cursor
set so=5

" infinite persistent undo
set undofile
set undodir=~/.vim/undodir

" Bindings
" Remove highlights with <Ctrl-l>
nnoremap <silent> <C-l> :nohl<CR><C-l> 
