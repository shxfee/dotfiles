" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      5.1
" Last Change:	May 02, 2020

" ================== Plugins ============================================
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'

Plug 'tpope/vim-fugitive'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.local/share/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'godlygeek/tabular'

" Syntax
Plug 'tpope/vim-git'
Plug 'jwalton512/vim-blade'
Plug 'posva/vim-vue'
Plug 'StanAngeloff/php.vim'
Plug 'othree/html5.vim'

" Color Schemes and UI
Plug 'itchyny/lightline.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'lifepillar/vim-gruvbox8'

call plug#end()

" ================== Plugin Setup ============================================
let g:netrw_banner = 0

let g:fzf_layout = { 'down': '~15%' }
let g:fzf_colors = {
    \'fg' : ['fg', 'Comment'],
    \'bg+': ['bg', 'Normal'], 'fg+': ['fg', 'Normal'],
    \'hl+': ['fg', 'Error'], 'hl' : ['fg', 'Error']
\}

let test#strategy = 'neovim'
let test#neovim#term_position = "belowright 10"


let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_expand_cr = 2

let g:UltiSnipsEditSplit = 'vertical' 

let g:lightline = {
    \'colorscheme': 'wombat',
    \'active': {
    \  'left': [ [ 'mode', 'paste'],
    \            [ 'gitbranch', 'readonly', 'filename', 'modified' ],
    \            [ 'cocstatus' ]],
    \  'right': [[ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype'] ],
    \},
    \'component_function': {
    \  'gitbranch': 'fugitive#head',
    \  'cocstatus': 'coc#status',
    \  'filename': 'LightlineFilename',
    \},
\}

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" ================== General Config =========================================
set nowrap
set number
set cursorline

set t_Co=256
set termguicolors
set bg=dark
" colorscheme nord
" colorscheme PaperColor
colorscheme solarized8_high

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

" Options For CoC
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" ================== Key bindings     =========================================
let mapleader='\'

nnoremap <leader>f :Files<cr>
nnoremap <leader>d :Dirs<cr>

nnoremap <leader>se :leftabove vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>

" for command line completion.
cnoremap <C-p> <up>

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
cmap w!! w :term sudo tee > /dev/null %


" Command abbrevs
cabbrev dg diffget /
cabbrev G vertical G


" ================== Auto commands =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.js,*.vue,*.blade.php setlocal shiftwidth=2 tabstop=2 softtabstop=2
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


" ================== CoC Config =========================================
let g:coc_global_extensions = [
    \'coc-eslint',
    \'coc-html',
    \'coc-json',
    \'coc-markdownlint',
    \'coc-phpls',
    \'coc-tailwindcss',
    \'coc-tsserver',
    \'coc-vetur',
    \'coc-css',
    \'coc-git'
    \]

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
