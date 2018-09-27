" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      3.0
" Last Change:	September 27, 2018

" ================== Plugins ============================================
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'

Plug 'tpope/vim-fugitive'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

Plug 'icymind/NeoSolarized'
Plug 'itchyny/lightline.vim'

Plug 'posva/vim-vue'

call plug#end()


" ================== Plugin Setup ============================================
let g:netrw_banner = 0
let g:lightline = { 'colorscheme': 'one' }

let g:fzf_layout = { 'down': '~15%' }
let g:fzf_colors = {
    \'bg+': ['bg', 'Normal'], 'fg+': ['fg', 'Normal'],
    \'hl+': ['fg', 'Error'], 'hl' : ['fg', 'Error']
\}

let g:test#strategy = 'neovim'
let test#neovim#term_position = "belowright 10"


let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_expand_cr = 2

let g:UltiSnipsEditSplit = 'vertical' 

let g:neosolarized_contrast = 'high'


" ================== General Config =========================================
set nowrap
set number
set relativenumber
set cursorline

set background=dark
colorscheme NeoSolarized
set termguicolors
set noshowmode

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
set foldmethod=indent
set foldminlines=0
set foldlevelstart=99

set ignorecase
set smartcase


" ================== Key bindings     =========================================
let mapleader='\'

" nnoremap <leader>dt :%s/\s\+$//e<cr>:w<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>d :Dirs<cr>
nnoremap <leader>g :Gstatus<cr>


nnoremap <leader>se :leftabove vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>sp :UltiSnipsEdit all<cr>
nnoremap <leader>tt :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>


" exit terminal
tnoremap <C-o> <C-\><C-n>
noremap <C-e> 20j
noremap <C-y> 20k

" Practical Vim
" Ctrl-L to clear search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<cr>
inoremap <silent> <C-l> <esc>:<C-u>nohlsearch<cr>a
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" ================== Auto commands =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.vue set ft=html
    autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=html shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.ctp  setlocal filetype=html syntax=php shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.html setlocal syntax=php shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup other
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd FileType fzf set laststatus=0
      \| autocmd BufLeave <buffer> set laststatus=2
augroup END

command! -bang Files
    \ call fzf#run(fzf#wrap('my-files', {'source': 'fd -t f', 'options': '--inline-info'}, <bang>0))

command! -bang Dirs
    \ call fzf#run(fzf#wrap('my-dirs', {'source': 'fd -t d'}, <bang>0))

command! -nargs=* T 10split | startinsert | terminal <args>
