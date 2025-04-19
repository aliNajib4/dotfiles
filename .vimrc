call plug#begin()

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" NNN explorer
  nnoremap <leader>e :NnnExplorer %:p:h<CR>
  " leader + n to picer
  let g:nnn#layout = { 'window': { 'width': 0.2, 'height': 0.6, 'highlight': 'Comment', "yoffset": 10000, "xoffset": 1000 } }

colorscheme dracula
let g:mapleader = " "
let g:maplocalleader = " "

set encoding=utf-8
set fileencoding=utf-8

set number
set relativenumber


set title
set autoindent
set smartindent
set hlsearch
set nobackup
set showcmd
set cmdheight=1
set laststatus=3
set expandtab
set scrolloff=10
set shell=fish
set backupskip=/tmp/*,/private/tmp/*
set ignorecase " Case insensitive searching UNLESS /C or capital in search
set smarttab
set breakindent
set shiftwidth=2
set tabstop=2
set nowrap " No Wrap lines
set backspace=start,eol,indent
set path+=** " Finding files - Search down into subfolders
set wildignore+=*/node_modules/*
set splitbelow " Put new windows below current
set splitright " Put new windows right of current
set splitkeep=cursor
set mouse=a
set clipboard=unnamedplus  " Sync with system clipboard

" Undercurl (may not work in all terminals)
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" Add asterisks in block comments
set formatoptions+=r

" Key mappings with noremap and silent options
nnoremap x "_x

" Leader mappings for paste/change/delete without affecting registers
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
vnoremap <Leader>p "0p
nnoremap <Leader>c "_c
nnoremap <Leader>C "_C
vnoremap <Leader>c "_c
vnoremap <Leader>C "_C
nnoremap <Leader>d "_d
nnoremap <Leader>D "_D
vnoremap <Leader>d "_d
vnoremap <Leader>D "_D

" Increment/decrement numbers
nnoremap + <C-a>
nnoremap - <C-x>

" Select all
nnoremap <C-a> gg<S-v>G

" Clear search highlights
nnoremap <Esc> :nohlsearch<CR>

" Terminal mode exit
tnoremap <Esc><Esc> <C-\><C-n>

" Tab management
nnoremap te :tabedit<CR>
nnoremap <tab> :tabnext<CR>
nnoremap <s-tab> :tabprev<CR>

" Window splitting
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>

" Window navigation
nnoremap sh <C-w>h
nnoremap sk <C-w>k
nnoremap sj <C-w>j
nnoremap sl <C-w>l

" Window resizing
nnoremap <C-w><left> <C-w><
nnoremap <C-w><right> <C-w>>
nnoremap <C-w><up> <C-w>+
nnoremap <C-w><down> <C-w>-

" Diagnostics navigation
nnoremap <C-j> :lnext<CR>

" JavaScript execution
nnoremap <leader>js :w !node<CR>
