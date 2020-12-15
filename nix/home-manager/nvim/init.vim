" basic stuff
filetype plugin indent on
set tabstop=8 softtabstop=8 shiftwidth=8 smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set encoding=utf-8
set number
set title
set nowrap
set lazyredraw
set timeoutlen=1000 ttimeoutlen=0
set colorcolumn=80
set clipboard=unnamed
set guicursor+=n:hor20-Cursor/lCursor
set cursorline

" space as leader
let mapleader = " "
let maplocalleader = " "

" reload vimrc
nnoremap <silent> <leader>r :w <CR> :source $MYVIMRC<CR>

" toggle comment line
map <silent> gc <Plug>NERDCommenterToggle

" enable vim-code-dark theme
autocmd ColorScheme * highlight Normal ctermbg=None guibg=None
autocmd ColorScheme * highlight CursorLine ctermbg=None guibg=None
autocmd ColorScheme * highlight LineNr ctermbg=None guibg=None
autocmd ColorScheme * highlight NonText ctermbg=None guibg=None
autocmd ColorScheme * highlight EndOfBuffer ctermbg=None guibg=None
autocmd ColorScheme * highlight Special ctermbg=None guibg=None
"colorscheme codedark

" Use system go tools instead of monorepo
let $USE_SYSTEM_GO=1

" easymotion
map s <Plug>(easymotion-w)
map S <Plug>(easymotion-b)

" Persistan undo
set undodir=~/.config/nvim/undo
set undofile
