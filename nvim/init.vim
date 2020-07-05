" =======================================================================
"                       NeoVim Configuration
" =======================================================================

source <sfile>:h/functions.vim

" ================== Plugins ============================================

call plug#begin('~/.vim/plugged')

" IDE
Plug 'tpope/vim-dispatch'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.local/share/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wakatime/vim-wakatime'
Plug 'SirVer/ultisnips'
Plug 'justinmk/vim-dirvish'
Plug 'vimwiki/vimwiki'
Plug 'janko-m/vim-test'
Plug 'jiangmiao/auto-pairs'

" Helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'

" Syntax & filetype
Plug 'tpope/vim-git'
Plug 'jwalton512/vim-blade'
Plug 'posva/vim-vue'
Plug 'StanAngeloff/php.vim'
Plug 'othree/html5.vim'

" Color Schemes & UI
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'

call plug#end()

" ================== Plugin Setup ============================================

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

let g:jellybeans_overrides = {
\    'b2ckground': { 'guibg': '121212' },
\}

let test#strategy = 'neovim'
let test#neovim#term_position = "belowright 15"
let test#php#phpunit#executable = './vendor/bin/phpunit'

let g:UltiSnipsEditSplit = 'vertical' 

let g:lightline = {
    \'colorscheme': 'jellybeans',
    \'active': {      
    \  'left': [ [ 'paste'],
    \            [ 'gitbranch', 'readonly', 'filename', 'modified' ],
    \            [ 'cocstatus' ]],
    \  'right': [[ 'percent' ],
    \            [ 'fileformat'] ],
    \},
    \'component_function': {
    \  'gitbranch': 'fugitive#head',
    \  'cocstatus': 'coc#status',
    \  'filename': 'LightlineFilename',
    \},
\}

" file explorer & disable netrw
let g:dirvish_mode=':sort ,^.*[\/],'
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

" Wiki Options
let g:vimwiki_hl_headers=1
let g:vimwiki_conceal_onechar_markers=0

" CoC Config
let g:coc_global_extensions = [
    \'coc-eslint',
    \'coc-json',
    \'coc-phpls',
    \'coc-tailwindcss',
    \'coc-css',
\]


" ================== General Config =========================================

set nowrap
set number
set relativenumber
set cursorline
set colorcolumn=80
set noshowmode

set termguicolors
colorscheme jellybeans
set bg=dark

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smartcase
set smartindent

set splitright
set splitbelow
set winminwidth=10
set winwidth=100
set scrolloff=8

" save only fold info
set viewoptions=cursor,folds
set foldmethod=indent
set foldminlines=0
set foldlevelstart=99
set noswapfile

set shell=/usr/bin/fish

set hidden
set cmdheight=2
set updatetime=50
set shortmess+=c
set signcolumn=yes

" ================== Key bindings     =========================================
nnoremap <SPACE> <Nop>
let mapleader=" "

" Primary leader maps
nnoremap <leader>d :Dirs<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :vertical Git<cr>

" Window leader maps
nnoremap <leader>wc :only<cr>:enew<cr>

" Config leader maps
nnoremap <leader>se :vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>

" for command line completion.
cnoremap <C-p> <up>

nnoremap <leader>tt :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>

nnoremap <leader>te :tabe<cr>

" Practical Vim
nnoremap <silent> <C-l> :<C-u>nohlsearch<cr>
inoremap <silent> <C-l> <esc>:<C-u>nohlsearch<cr>a
cmap w!! w :term sudo tee > /dev/null %
tnoremap <C-o> <C-\><C-n>

" Coc Maps
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call ShowDocumentation()<CR>

" ================== Abbreviations =========================================

cabbrev h vertical help
iabbrev <expr> dts strftime("%c (MVT)")


" ================== Auto commands =========================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.js,*.vue,*.blade.php,*.md setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.md setlocal shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=manual

    " silent create all required directories for file
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END

augroup other
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    "autocmd FileType fzf set laststatus=0 signcolumn=no
    "  \| autocmd BufLeave <buffer> set laststatus=2 signcolumn=yes
augroup END

augroup remember_folds
  autocmd!
  let blacklist = ['fzf', '', 'dirvish', 'help']
  autocmd BufWinLeave ?* if index(blacklist, &ft) < 0 | mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

augroup dirvish_config
    autocmd!
    autocmd FileType dirvish setlocal nonumber
    autocmd FileType dirvish nnoremap <buffer> % :edit %
    autocmd FileType dirvish nnoremap <buffer> d :!mkdir %
    autocmd FileType dirvish nnoremap <buffer> gq :q<cr>
augroup END

augroup vim_plug
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> gq :q<cr>
augroup END

augroup coc_config
    autocmd!
    autocmd BufNewFile,BufRead *.css,*.html,*.blade.php let b:coc_additional_keywords = ["-"]
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

augroup wiki_config
    autocmd!
    " - is always bound to dirup no matter where in vim I am
    autocmd FileType vimwiki nmap <buffer> - <Plug>(dirvish_up)
    autocmd FileType vimwiki nmap <buffer> + <Plug>VimwikiRemoveHeaderLevel
    autocmd FileType vimwiki nmap <buffer> # <Plug>VimwikiNormalizeLink
    autocmd FileType vimwiki setlocal spell textwidth=79
    autocmd FileType vimwiki let b:coc_suggest_disable = 1
augroup END


" ================== Commands ===========================================
command! -bang Files
    \ call fzf#run(fzf#wrap('my-files', {'source': 'fd --type f --hidden', 'options': '--inline-info'}, <bang>0))

command! -bang Dirs
    \ call fzf#run(fzf#wrap('my-dirs', {'source': 'fd --type d --hidden', 'options': '--inline-info'}, <bang>0))

command! -nargs=* T 10split | startinsert | terminal <args>
