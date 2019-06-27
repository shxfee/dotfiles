" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      4.0
" Last Change:	June 27, 2019

" ================== Plugins ============================================
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'

Plug 'tpope/vim-fugitive'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.local/share/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'

Plug 'godlygeek/tabular'
Plug 'posva/vim-vue'
Plug 'jwalton512/vim-blade'
Plug 'w0rp/ale'

" Color Schemes and UI
Plug 'arcticicestudio/nord-vim'
Plug 'icymind/NeoSolarized'
Plug 'itchyny/lightline.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'lifepillar/vim-solarized8'

call plug#end()

" ================== Plugin Setup ============================================
let g:netrw_banner = 0

let g:fzf_layout = { 'down': '~15%' }
let g:fzf_colors = {
    \'fg' : ['fg', 'Comment'],
    \'bg+': ['bg', 'Normal'], 'fg+': ['fg', 'Normal'],
    \'hl+': ['fg', 'Error'], 'hl' : ['fg', 'Error']
\}

let g:lightline = {
    \'active': {
    \  'left': [ [ 'mode', 'paste'],
    \            [ 'lint' ],
    \            [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \  'right': [[ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype'] ],
    \},
    \'component_function': {
    \  'gitbranch': 'fugitive#head',
    \},
    \'component_expand': {
    \  'lint': 'LinterStatus',
    \},
    \'component_type': {
    \  'lint': 'error',
    \},
\}

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '%dE %dW',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

augroup ALE
    autocmd!
    autocmd User ALELintPost call lightline#update()
augroup END

let g:test#strategy = 'neovim'
let test#neovim#term_position = "belowright 10"


let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_expand_cr = 2

let g:UltiSnipsEditSplit = 'vertical' 

let g:ale_sign_error = '❌'
let g:ale_set_signs = 0

" ================== General Config =========================================
set nowrap
set number
set relativenumber
set cursorline

set t_Co=256
set termguicolors
colorscheme solarized8_high
set bg=light

set noshowmode

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set shiftround

set splitright
set splitbelow
set winwidth=100
set winminwidth=10
set scrolloff=5
set foldmethod=indent
set foldminlines=0
set foldlevelstart=99

set ignorecase
set smartcase

set shell=/usr/bin/fish

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

" Practical Vim
" Ctrl-L to clear search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<cr>
inoremap <silent> <C-l> <esc>:<C-u>nohlsearch<cr>a
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <C-p> <Up>


" Command abbrevs
cabbrev dg diffget /


" ================== Auto commands =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.vue,*.blade.php setlocal shiftwidth=2 tabstop=2 softtabstop=2
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
