" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      2.0
" Last Change:	April 7, 2015


" ================== Vundle Setup  ============================================
set nocompatible
filetype off

set rtp+=~/.dotfiles/vim/bundle/Vundle.vim
call plug#begin('~/.vim_plugins')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'

Plug 'StanAngeloff/php.vim'
Plug 'othree/html5.vim'
Plug 'majutsushi/tagbar'

Plug 'gerw/vim-HiLinkTrace'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


filetype plugin indent on
syntax on
runtime macros/matchit.vim


" ================== Plugin Settings  =========================================
" Plugin settings
let g:ctrlp_map = '<leader>f'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'

" Ignored files in ctrlp listing
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore "**/*.pyc"
        \ -g ""'
endif

let g:UltiSnipsEditSplit="vertical"
let g:netrw_banner=0

let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" Remove airline separators
let g:airline_left_sep  = ' '
let g:airline_left_sep  = ' '
let g:airline_right_sep = ' '
let g:airline_right_sep = ' '
let g:airline_theme='badwolf'


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
set number
set relativenumber
set cursorline
set title
set t_Co=256                    " 256 color terminal
colorscheme mustang
set laststatus=2                " Always display status line
set winwidth=115
set winminwidth=25
set scrolloff=5
set sidescrolloff=0

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"


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
set history=100
set undolevels=100

" Completion
set wildmode=longest,full
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=tmp/**
set wildignore+=log/**


" ================== Abbreviations  ===========================================
cabbrev amc !php artisan make:controller
cabbrev amm !php artisan make:model
cabbrev amg !php artisan make:migration
cabbrev amr !php artisan make:request

cabbrev agg !php artisan migrate:refresh
cabbrev ags !php artisan db:seed

cabbrev cdc app/Http/Controllers
cabbrev cdm app
cabbrev cdv resources/views
cabbrev cdr app/Http/Requests
cabbrev cdg database/migrations
cabbrev cda resources/assets

cabbrev mpu nmap ,t :!clear & phpunit --colors <C-r>=shellescape(expand('%'), 1)<cr>
cabbrev mps nmap ,t :!clear & phpspec run <C-r>=shellescape(expand('%'), 1)<cr>

cabbrev cpb CtrlPBufTag
cabbrev cpt CtrlPTag


" ================== Key bindings     =========================================
let mapleader=','
noremap \ ,

nnoremap <leader>se :vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>dt :%s/\s\+$//e<CR>:w<CR>
nnoremap <leader>rp :!clear;python3 %<CR>
nnoremap <leader>tb :TagbarToggle<CR>

" Practical Vim
" Ctrl-L to clear search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>
inoremap <silent> <C-l> <esc>:<C-u>nohlsearch<CR>a
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'



" ================== Auto commands    =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.blade.php  set syntax=php
    autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=html shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.ctp  setlocal filetype=html syntax=php shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.html setlocal syntax=php shiftwidth=2 tabstop=2 softtabstop=2
augroup END
