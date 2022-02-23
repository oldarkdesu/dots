" Vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'easymotion/vim-easymotion'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'
Plug 'sirver/ultisnips'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Plug 'preservim/vim-markdown'

" pandoc
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

" Normal stuff "
""""""""""""""""
set nocompatible
filetype off
set encoding=utf-8
set fileformat=unix

set path=.,**
set path+=**
set wildmenu

" use system clipboard. (needs xclip package or something similar)
set clipboard=unnamedplus
set mouse=a " use the mouse

" Allow the cursor to move one character past EOL sometimes (e.g. will not
" work with the $ movement)
" set virtualedit+=onemore

" Keys
""""""""""""""""""""""""""""
let mapleader = " "
nnoremap j gj
nnoremap k gk
" nnoremap $ g$

" Better window navigation
nnoremap <C-h>     <C-w>h
nnoremap <C-j>     <C-w>j
nnoremap <C-k>     <C-w>k
nnoremap <C-l>     <C-w>l
nnoremap <C-Left>  <C-w><Left>
nnoremap <C-Down>  <C-w><Down>
nnoremap <C-Up>    <C-w><Up>
nnoremap <C-Right> <C-w><Right>

" Better window resizing
nnoremap <C-A-h>     :vertical resize -5<CR>
nnoremap <C-A-j>     :resize -5<CR>
nnoremap <C-A-k>     :resize +5<CR>
nnoremap <C-A-l>     :vertical resize +5<CR>
nnoremap <C-A-Left>  :vertical resize -5<CR>
nnoremap <C-A-Down>  :resize -5<CR>
nnoremap <C-A-Up>    :resize +5<CR>
nnoremap <C-A-Right> :vertical resize +5<CR>

		" ene
" From Vim's wikia: https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
" The command :m .+1 (which can be abbreviated to :m+) moves the current line 
" to after line number .+1 (current line number + 1). That is, the current line is moved down one line.
" 
" The command :m .-2 (which can be abbreviated to :m-2) moves the current line 
" to after line number .-2 (current line number − 2). That is, the current line 
" is moved up one line.
" 
" After visually selecting some lines, entering :m '>+1 moves the selected lines 
" to after line number '>+1 (one line after the last selected line; '> is a mark 
" assigned by Vim to identify the selection end). That is, the block of selected 
" lines is moved down one line.
" 
" The == re-indents the line to suit its new position. For the visual-mode 
" mappings, gv reselects the last visual block and = re-indents that block.
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" custom
" split line into 2 lines 
nnoremap <A-J> 079lebi<CR><ESC>
nnoremap <leader>e :Lexplore 15<cr>
nnoremap <leader>w :w<cr>

" Commands 
"""""""""""""
command -nargs=1 SetTabWidth set shiftwidth=<args> tabstop=<args> softtabstop=<args>
command Wso w | so %

" Visual customization "
"""""""""
set number
set norelativenumber
syntax enable

colorscheme gruvbox
let g:airline_theme='gruvbox'

" unset the background:
hi! Normal ctermbg=NONE guibg=NONE

" highlight cursor's current row and column
set cursorline
set cursorcolumn
set showtabline=2 "Always show opened buffers in the tab bar at the top

" leave some space between the bottom of the screen and the cursor
set scrolloff=7
set sidescrolloff=7
" draw a line to remember to keep lines short
set colorcolumn=80

" show tabs as |, end of line as ↲, trail, lead spaces and multipe spaces as ·
set list
set listchars=eol:↲,tab:\|\ ,trail:·,lead:·,multispace:·

" Tab characters
set shiftwidth=3 " indentation level
set tabstop=3    " tabs
set softtabstop=3

set noexpandtab
set autoindent


" This gets rid of the nasty _ italic bug in tpope's vim-markdown
" block $$...$$
syn region math start=/\$\$/ end=/\$\$/
" inline math
syn match math '\$[^$].\{-}\$'

" actually highlight the region we defined as "math"
hi link math Statement



" Stuff for pluggins
"""""""""""""""""""""
" preservim/vim-markdown
set conceallevel=2
let g:vim_markdown_folding_disabled = 1	
let g:tex_conceal = ""
let g:vim_markdown_folding_disabled = 1 " disable folds by default
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2


" " pandoc-syntax
" augroup pandoc_syntax
"     au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
" augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set noswapfile

set nobackup
set nowritebackup

" new splits go to the bottom and right
set splitbelow
set splitright

" wrap the cursor when trying to move to other line
set whichwrap=<,>,[,],~,b,s
