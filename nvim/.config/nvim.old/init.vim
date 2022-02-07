" Vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'
Plug 'sirver/ultisnips'

call plug#end()

" Normal stuff "
""""""""""""""""
set nocompatible
filetype off
set encoding=utf-8

set number
set norelativenumber
syntax enable
set fileformat=unix

set path=.,**
set path+=**
set wildmenu

set hidden
set nobackup
set noswapfile

set clipboard=unnamedplus " use system clipboard. (needs xclip package or something similar)
set mouse=a " use the mouse
" Allow the cursor to move one character past EOL sometimes (e.g. will not
" work with the $ movement)
set virtualedit+=onemore
let mapleader = " "
map <leader>e :Lexplore 30<cr>
nnoremap j gj
nnoremap k gk
nnoremap $ g$


" leave some space between the bottom of the screen and the cursor
set scrolloff=7

" draw a line to remember to keep lines short
set colorcolumn=80



" Visual customization "
"""""""""
colorscheme gruvbox
let g:airline_theme='gruvbox'

" unset the background:
hi! Normal ctermbg=NONE guibg=NONE

" highlight cursor's current row and column
set cursorline
set cursorcolumn

" show tabs as |, end of line as ↲, trail, lead spaces and multipe spaces as ·
set list
set listchars=eol:\↲,tab:\|\ ,trail:·,lead:·,multispace:·

" Tabs
set shiftwidth=3 " indentation level
set tabstop=3    " tabs
set softtabstop=3
set noexpandtab
set autoindent
" NERDTree "
""""""""""""
" todo
