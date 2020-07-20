call plug#begin('~/.local/share/nvim/plugged')

Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'chrisbra/Colorizer'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tomasiser/vim-code-dark'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'

call plug#end()

" basic stuff
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase
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
set clipboard=unnamedplus

" space as leader
let mapleader = " "

" gitignore for fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" fzf
map <Leader><Leader> :Files <CR>

" reload vimrc
nnoremap <silent> <leader>r :w <CR> :source $MYVIMRC<CR>

" toggle comment line
map <silent> gc <Plug>NERDCommenterToggle

" enable vim-code-dark theme
colorscheme codedark

" easymotion
map s <Plug>(easymotion-w)
map S <Plug>(easymotion-b)

" Persistan undo
set undodir=~/.config/nvim/undo
set undofile
