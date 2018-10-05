call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Yggdroot/indentLine'
Plug 'liuchengxu/space-vim-dark'
Plug 'tpope/vim-commentary'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'posva/vim-vue'

call plug#end()

" Commentary
" nmap <cmd-/> <Plug>Commentary

" FZF
nnoremap <C-P> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" theme
set t_Co=256
set t_ut=
let g:space_vim_dark_background = 233
colorscheme space-vim-dark
hi Comment cterm=italic

" tab width
set softtabstop=2
set shiftwidth=2
set expandtab

" indetLine
let g:indentLine_leadingSpaceChar  = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_char = '│'
let g:indentLine_color_term = 239

" escape key timeout fix
set timeout           " for mappings
set timeoutlen=1000   " default value
set ttimeout          " for key codes
set ttimeoutlen=10    " unnoticeable small value

" turn on line-numbers
set number
