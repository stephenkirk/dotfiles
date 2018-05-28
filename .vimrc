"set relativenumber
set number
set wildmenu " For file switching with :b
syntax on
set clipboard=unnamed " For sharing clipboard with the system
set scrolloff=2         " 2 lines above/below cursor when scrolling
set hlsearch
set autoindent          " Copy the same indent from the previous line

" Bindings
nnoremap <silent> <C-l> :nohl<CR><C-l> " Remove highlights with <Ctrl-l>
