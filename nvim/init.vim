" =============================================================================
"                       NeoVim Configuration
" =============================================================================

source <sfile>:h/functions.vim


" ================== Plugins ==================================================

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
Plug 'tpope/vim-projectionist'

" Vimfu
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'

" Syntax & UI
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'

" Temporary
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}

call plug#end()


" ================== Plugin Setup =============================================

" let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
let g:fzf_layout = { 'down': '~25%' }

" jellybeanset g:jellybeans_overrides = {
" \    'b2ckground': { 'guibg': '121212' },
" \}

let test#strategy = 'neovim'
let test#neovim#term_position = "belowright 15"
let test#php#phpunit#executable = './vendor/bin/phpunit'

let g:UltiSnipsEditSplit = 'vertical' 

let g:lightline = {
    \'colorscheme': 'google',
    \'active': {      
    \  'left': [ [ 'paste'],
    \            [ 'gitbranch' ],
    \            [ 'filename', 'modified', 'readonly' ],
    \            [ 'cocstatus' ]],
    \  'right': [[ 'percent' ],
    \            [ 'filetype'] ],
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

" Temporary
let g:vim_be_good_floating = 0


" ================== General Config ===========================================

set nowrap
set number
set relativenumber
set nocursorline
set colorcolumn=80
set noshowmode

set termguicolors
colorscheme google
"set background=light

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set ignorecase
set smartcase
set smartindent

set splitright
set splitbelow
set winminwidth=10
set winwidth=100
set scrolloff=8

" save only fold info
set inccommand=nosplit
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

" ================== Key bindings =============================================
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
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Coc Maps
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call ShowDocumentation()<CR>


" ================== Abbreviations ============================================

cabbrev h vertical help
cabbrev PI PlugInstall
cabbrev PC PlugClean
cabbrev CE vsplit ~/dotfiles/nvim/colors/google.vim
iabbrev <expr> dts strftime("%c (MVT)")
iabbrev <expr> ds strftime("%Y-%m-%d")


" ================== Commands =================================================
command! -bang Files
    \ call fzf#run(fzf#wrap('my-files', {'source': 'fd --type f --hidden', 'options': '--inline-info'}, <bang>0))

command! -bang Dirs
    \ call fzf#run(fzf#wrap('my-dirs', {'source': 'fd --type d --hidden', 'options': '--inline-info'}, <bang>0))

command! -nargs=* T 10split | startinsert | terminal <args>


" ================== Auto commands ============================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.js,*.vue,*.blade.php,*.md setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.md setlocal shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=manual

    " silent create all required directories for file
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END

augroup term_options
    autocmd!
    autocmd FileType fzf set laststatus=0 signcolumn=no
      \| autocmd BufLeave <buffer> set laststatus=2 signcolumn=yes

    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

augroup remember_folds
  autocmd!
  let blacklist = ['fzf', '', 'dirvish', 'help']
  autocmd BufWinLeave ?* if index(blacklist, &ft) < 0 | mkview 1
  autocmd BufWinEnter ?* silent! loadview 1
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

autocmd! FileType vimwiki call AutoCmdVimWiki()
function! AutoCmdVimWiki()
    nmap <buffer> - <Plug>(dirvish_up)
    nmap <buffer> + <Plug>VimwikiRemoveHeaderLevel
    nmap <buffer> # <Plug>VimwikiNormalizeLink
    setlocal spell textwidth=79
    let b:coc_suggest_disable = 1
endfunction

autocmd! FileType dirvish call AutoCmdDirvish()
function! AutoCmdDirvish()
    setlocal nonumber norelativenumber
    setlocal colorcolumn=
    nnoremap <buffer> % :edit %
    nnoremap <buffer> d :!mkdir %
    nnoremap <buffer> gq :q<cr>
endfunction
