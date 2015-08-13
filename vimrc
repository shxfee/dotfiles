" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      2.0
" Last Change:	April 7, 2015


" ================== Vundle Setup  ============================================
set nocompatible
filetype off

set rtp+=~/.dotfiles/vim/bundle/Vundle.vim
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
runtime macros/matchit.vim


" ================== Plugin Settings  =========================================
" Plugin settings
let g:ctrlp_map = '<leader>f'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_clear_cache_on_exit = 1

if executable('ag')
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore "**/*.pyc"
        \ -g ""'
endif

let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'

let g:UltiSnipsEditSplit="vertical"

let g:netrw_banner=0


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
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=tmp/**
set wildignore+=log/**


" ================== Abbreviations  ===========================================
cabbrev amc !php artisan make:controller
cabbrev amm !php artisan make:model
cabbrev amg !php artisan make:migration
cabbrev amr !php artisan make:request

cabbrev agm !php artisan migrate
cabbrev ags !php artisan db:seed

cabbrev cdc app/Http/Controllers
cabbrev cdm app
cabbrev cdv resources/views
cabbrev cdr app/Http/Requests
cabbrev cdg database/migrations

cabbrev mpu nmap ,t :!phpunit <C-r>=shellescape(expand('%'), 1)<cr>


" ================== Key bindings     =========================================
let mapleader=','
noremap \ ,

nnoremap <leader>se :vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>dt :%s/\s\+$//e<CR>:w<CR>
nnoremap <leader>rp :!clear;python3 %<CR>

" Parses JSON to be readable
" nnoremap =j :%!python -m json.tool<CR>

" Practical Vim
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'



" ================== Auto commands    =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.blade.php  set syntax=php
    autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=html shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.ctp  setlocal filetype=html syntax=php shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.html setlocal syntax=php shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufWritePost *Spec.php !clear && phpspec -v run
    autocmd BufWritePost *test.php !clear && phpunit %
    autocmd BufWritePost *test.py  !clear && python3  % -f -b -v
augroup END
