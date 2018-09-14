" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      2.0
" Last Change:	April 7, 2015

" ================== Plugins ============================================
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'

Plug 'tpope/vim-fugitive'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

Plug 'icymind/NeoSolarized'
Plug 'itchyny/lightline.vim'

Plug 'posva/vim-vue'

call plug#end()


" ================== Plugin Setup ============================================
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_colors = { 'bg+': ['bg', 'Normal'], 'fg+': ['fg', 'Normal']}


" ================== General Config =========================================
set nowrap
set number
set relativenumber
set cursorline

colorscheme NeoSolarized
set termguicolors

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set shiftround 

set splitright
set splitbelow
set winwidth=115
set winminwidth=25
set scrolloff=5
set sidescrolloff=0

set ignorecase
set smartcase


" ================== Key bindings     =========================================
let mapleader='\'

nnoremap <leader>se :leftabove vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>dt :%s/\s\+$//e<cr>:w<cr>

nnoremap <leader>f :FZF<cr>

" Practical Vim
" Ctrl-L to clear search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<cr>
inoremap <silent> <C-l> <esc>:<C-u>nohlsearch<cr>a
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" ================== Auto commands =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=html shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.ctp  setlocal filetype=html syntax=php shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.html setlocal syntax=php shiftwidth=2 tabstop=2 softtabstop=2
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
