" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      2.0
" Last Change:	April 7, 2015


" ================== Vundle Setup  ============================================
set nocompatible
filetype off

set rtp+=~/.vim_bundle/Vundle.vim
call vundle#begin('~/.vim_bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'SirVer/ultisnips'

Plugin 'bling/vim-airline'
Plugin 'gerw/vim-HiLinkTrace'

Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'

call vundle#end()
filetype plugin indent on


" ================== Plugin Settings  =========================================
" Plugin settings
let g:ctrlp_map = '<leader>f'
let g:ctrlp_working_path_mode = ''

let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'

let g:UltiSnipsEditSplit="vertical"


" ================== General Config   =========================================
" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set shiftround                  " Relative indentation

" UI settings
set nonumber
set relativenumber
set cursorline
set title
set t_Co=256                    " 256 color terminal
colorscheme mustang
set laststatus=2                " Always display status line
set winwidth=115
set winminwidth=25
set winheight=30
set scrolloff=5
set sidescrolloff=0

" Editor settings
set nowrap
set ignorecase
set smartcase
set showmatch                   " Show matching parenthesis
set incsearch                   " Show search matches as you type
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

" General settings
set viminfo+=n~/.vim_info
set visualbell                  " don't beep
set noerrorbells                " don't beep

" Undo Settings
set undofile
set undodir=~/.vim/undo/
set history=1000
set undolevels=1000

" Completion
set wildignore=*.swp
set wildignore+=tmp/**
set wildignore+=log/**
set wildignore+=*.png,*.jpg,*jpeg,*.gif,*.pyc


" ================== Key bindings     =========================================
let mapleader=','
noremap \ ,

nnoremap <leader>se :vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>dt :%s/\s\+$//e<CR>:w<CR>
nnoremap <leader>rp :!clear;python3 %<CR>

" Remove <C-w> for delete word in insert mode
inoremap <C-w> <Esc>
" Parses JSON to be readable
" nnoremap =j :%!python -m json.tool<CR>

" Center screen after motion
nnoremap G Gzz
nnoremap n nzz
nnoremap N Nzz

" Practical Vim
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" ================== Auto commands    =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.html       set syntax=php
    autocmd BufNewFile,BufRead *.blade.php  set syntax=php
    autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=html shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.ctp  setlocal filetype=html syntax=php shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufWritePost *Spec.php !clear && phpspec -v run
    autocmd BufWritePost *test.php !clear && phpunit %
    autocmd BufWritePost *test.py  !clear && python3  % -f -b -v
augroup END
