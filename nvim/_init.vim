" =============================================================================
"                       NeoVim Configuration
" =============================================================================


" ================== Plugins ==================================================


call plug#begin('~/.local/share/nvim/site/plug')

" IDE
Plug 'rafcamlet/nvim-luapad'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.local/share/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'
Plug 'justinmk/vim-dirvish'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'janko-m/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'kkoomen/vim-doge'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-dadbod'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rafcamlet/coc-nvim-lua'

" Vimfu
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'
Plug 'justinmk/vim-sneak'
Plug 'takac/vim-hardtime'

" Syntax & UI
Plug 'sheerun/vim-polyglot'
Plug 'nanotech/jellybeans.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'

call plug#end()


" ================== Plugin Setup =============================================

let g:jellybeans_use_gui_italics = 0

let test#strategy = 'neovim'
let test#neovim#term_position = "belowright 15"
let test#php#phpunit#executable = './vendor/bin/phpunit'

let g:UltiSnipsEditSplit = 'vertical' 

let g:lightline = { 'active': {}, 'inactive': {}, 'component_function': {} }
let g:lightline.colorscheme = 'jellybeans'
let g:lightline.active.left = [['paste'], ['git'], ['filename', 'modified']]
let g:lightline.active.right = [['percent'], ['line'], ['filetype'], ['readonly']]
let g:lightline.inactive.left = []
let g:lightline.component_function.git = 'fugitive#head'
let g:lightline.component_function.filename = 'LightlineFilename'

" file explorer & disable netrw
let g:dirvish_mode=':sort ,^.*[\/],'
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

" Wiki Options
let g:vimwiki_hl_headers=1
let g:vimwiki_conceal_onechar_markers=0
let g:vimwiki_folding='list:quick'

" Sneak Config
let g:sneak#use_ic_scs = 1

" CoC Config
let g:coc_global_extensions = [
    \'coc-json',
    \'coc-phpls',
    \'coc-tailwindcss',
    \'coc-css',
    \'coc-eslint',
    \'coc-vetur',
\]

" Temporary
let g:vim_be_good_floating = 0

let g:AutoPairsShortcutToggle = ''
let g:AutoPairsMultilineClose = 0

let g:doge_mapping = ''

" ================== General Config ===========================================

set nowrap
set noruler
set number
set relativenumber
set nocursorline
set colorcolumn=80
set noshowmode
set scrolloff=3

set termguicolors
colorscheme jellybeans

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

" save only fold info
set inccommand=nosplit
set viewoptions=cursor,folds
set foldmethod=indent
set foldminlines=0
set foldlevelstart=99
set noswapfile

let $BASH_ENV='~/.bash_aliases'
set spellfile=~/.local/share/nvim/spell/en.utf-8.add

set hidden
set cmdheight=2
set updatetime=50
set shortmess+=cI
set signcolumn=yes
set nrformats+=alpha
set completeopt=menuone,noinsert,noselect

" ================== Key bindings =============================================
nnoremap <SPACE> <Nop>
let mapleader=" "

" Primary leader maps
nnoremap <leader>fd  :Dirs<cr>
nnoremap <leader>ff  :Files<cr>
nnoremap <leader>fg  :Ag<cr>
nnoremap <leader>fh  :Helptags<cr>
nnoremap <leader>fc  :Commits<cr>

nnoremap <leader>gg :vertical Git<cr>

" Window leader maps
nnoremap <leader>wc :wa<cr>:only<cr>:enew<cr>

" Open leader maps
nnoremap <silent> <leader>od :lua require('my.laravel').open_adminer()<cr>
nnoremap <silent> <leader>oa :lua require('my.laravel').open_app()<cr>

" Config leader maps
nnoremap <leader>se :vsplit $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>sb :source %<cr>

" Projection mappings
nnoremap <leader>pa :AV<cr>
nnoremap <leader>p <NOP>

" for command line completion.
cnoremap <C-p> <up>
cnoremap <C-n> <down>

nnoremap <silent> <leader>tt :<c-u>lua require('my.utils').run_nearest_or_last_test()<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>

nnoremap <leader>rl <Plug>(Luadev-RunLine)
vnoremap <leader>rs <Plug>(Luadev-Run)

nnoremap <leader>te :tabe<cr>

nnoremap <leader>2 :DogeGenerate<cr>

" Practical Vim
nnoremap <silent> <c-l> :<C-u>nohlsearch<cr>
inoremap <silent> <c-l> <esc>:<C-u>nohlsearch<cr>a
cnoremap w!! w :term sudo tee > /dev/null %
tnoremap <C-o> <C-\><C-n>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Copy paste from system register
vnoremap <a-y> "+y
nnoremap <a-p> "+p
vnoremap <a-p> "+p
inoremap <a-p> <c-r>+

noremap gV `[v`]

" Coc Maps
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :lua require('my.utils').open_documentation()<CR>

" Add count jumps to jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


" ================== Abbreviations ============================================

cabbrev DD DB describe
cabbrev DS DB show tables
cabbrev h vertical help
cabbrev PI PlugInstall
cabbrev PC PlugClean
cabbrev CE vsplit ~/dotfiles/nvim/colors/google.vim
iabbrev <expr> dts strftime("%c (MVT)")
iabbrev <expr> ds strftime("%Y-%m-%d")


" ================== Commands =================================================
" I have gotten used to using ctrl-k/j to navigate
" however i feel its better to be consistent and use ctrl-n/p instead. so
" binding them to ignore

let s:fzf_opts = ['--info=inline', '--prompt=>', '--bind=ctrl-j:ignore,ctrl-k:ignore']

command! -bang Files
    \ call fzf#run(fzf#wrap('my-files', {'source': 'fd --type f --hidden --exclude .git', 'options': s:fzf_opts}, <bang>0))

command! -bang Dirs
    \ call fzf#run(fzf#wrap('my-dirs', {'source': 'fd --type d --hidden --exclude .git', 'options': s:fzf_opts}, <bang>0))


command! -nargs=* T 10split | startinsert | terminal <args>


" ================== Auto commands ============================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.js,*.vue,*.blade.php setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.blade.php setlocal ft=blade shiftwidth=2 tabstop=2 softtabstop=2

    " silent create all required directories for file
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    autocmd VimEnter * silent! lua require('my.laravel').set_db_connection_string()
augroup END


augroup reload_config
    autocmd!
    autocmd BufWritePost init.vim silent! lua require('my.utils').after_config_update()
augroup END


augroup term_options
    autocmd!
    autocmd FileType fzf map <c-j> <nop>
    autocmd FileType fzf map <c-k> <nop>
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END


augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          \ |   exe "normal! g`\""
          \ | endif
augroup END


augroup vim_plug
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> gq :q<cr>
augroup END


augroup coc_config
    autocmd!
    autocmd BufNewFile,BufRead *.css,*.html,*.blade.php let b:coc_additional_keywords = ["-"]
augroup END


autocmd! FileType vimwiki call AutoCmdVimWiki()
function! AutoCmdVimWiki()
    nmap <buffer> - <Plug>(dirvish_up)
    nmap <buffer> + <Plug>VimwikiRemoveHeaderLevel
    nmap <buffer> # <Plug>VimwikiNormalizeLink
    setlocal spell wrap linebreak breakindent breakindentopt=shift:0,min:80
    setlocal shiftwidth=2 tabstop=2 softtabstop=2
    let b:coc_suggest_disable = 1
endfunction


autocmd! FileType dirvish call AutoCmdDirvish()
function! AutoCmdDirvish()
    setlocal nonumber norelativenumber
    setlocal colorcolumn=
    nnoremap <buffer> % :edit %
    nnoremap <buffer> d :!mkdir %
    nnoremap <buffer> m :!mv getline('.')
    nnoremap <buffer> gq :q<cr>
endfunction


" ================== Temporary ================================================
nnoremap <silent> <leader>ea :call ExpandArray()<cr>
fun! ExpandArray() abort
    execute "normal! $F[a\<cr>\<esc>f]i\<cr>\<esc>k"
    execute "s/,/,\r/g"
    execute "normal! =a["
endfun

vnoremap zy :call CopyFoldHeader()<cr>

fun! CopyFoldHeader() range
    let @z = ''

    for i in range(a:firstline, a:lastline)
        if i == foldclosed(i) || foldclosed(i) == -1
            let line = substitute(getline(i), '^\s*[*,#,-]\s*\(\[ \]\)*', '', '')
            let @z .= trim(line) . "\n"
        endif
    endfor

    let @+ = @z
endfun

" Generate a filename from project root for lightline
function! LightlineFilename() abort
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:]
    endif
    return expand('%')
endfunction

" Migrating my config over to lua
" Requiring it as the last item to ensure I am able to override
luafile ~/.config/nvim/lua/my/init.lua
