" Vundle Configuration.
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Initialize plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'SirVer/ultisnips'
Plugin 'krisajenkins/vim-pipe'
Plugin 'StanAngeloff/php.vim'
Plugin 'tpope/vim-repeat'
" Plugin 'vim-scripts/dbext.vim'


call vundle#end()            " required
filetype plugin indent on    " required


" Leader mappings
let mapleader = ","
let python_highlight_all = 1

nnoremap <leader>p "+p
nnoremap <leader>P o<Esc>"+p
vnoremap <leader>y "+y
nnoremap <leader>y "+yy
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j
nnoremap <leader>se :vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>dt :%s/\s\+$//e<CR>:w<CR>
inoremap <leader>kj <esc>
vnoremap <leader>c :s!^!//!<CR>
vnoremap <leader>uc :s!^//!!<CR>
nnoremap <leader>pr :!clear;python %<CR>


" Leader mappings for vim-fugitive
nnoremap <leader>gw  :Gwrite<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gc  :Gcommit<CR>
nnoremap <leader>gs  :Gstatus<CR>
nnoremap <leader>gpl :Git push -u origin master<CR>
nnoremap <leader>gpu :Git pull<CR>


" Remove <C-w> for delete word in insert mode
inoremap <C-w> <Esc>
" Parses JSON to be readable
"nnoremap =j :%!python -m json.tool<CR>

" Center screen after motion
nnoremap G Gzz
nnoremap <c-u> <c-u>M
nnoremap <c-d> <c-d>M


" Set up the theme and status line
set t_Co=256
colorscheme WGB

" Plugin settings
set laststatus=2
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:CommandTTraverseSCM='pwd'
let g:CommandTMaxHeight=7
let g:UltiSnipsEditSplit="vertical"
let g:netrw_liststyle=0

autocmd BufNewFile,BufRead *.ctp  set syntax=php
autocmd BufNewFile,BufRead *.html set syntax=php

" Set other misc options
set number
set tabstop=4
set shiftwidth=4
set expandtab           " Replace tabs with spaces
set smarttab            " Spaces will be deleted in bunches of tabstops
set autoindent          " always set autoindenting on

set winwidth=102        " Set selected window width
set winheight=30        " Set selected window height

set nowrap              " don't wrap lines
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set shiftround          " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch           " set show matching parenthesis
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase,
set incsearch           " show search matches as you type
set history=1000        " remember more commands and search history
set undolevels=1000     " use many muchos levels of undo
set wildignore=*.swp    " Ignore these files
set title               " change the terminal's title
set visualbell          " don't beep
set noerrorbells        " don't beep
set cursorline          " Highlight current line


" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
