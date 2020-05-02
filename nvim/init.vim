" Maintainer:	Hussain Shafeeu (shxfee@gmail.com)
" Version:      4.1
" Last Change:	June 27, 2019

" ================== Plugins ============================================
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
" Plug 'SirVer/ultisnips'

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
Plug 'posva/vim-vue'
Plug 'jwalton512/vim-blade'
" Plug 'w0rp/ale'

" Color Schemes and UI
Plug 'itchyny/lightline.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

" ================== Plugin Setup ============================================
let g:netrw_banner = 0

let g:fzf_layout = { 'down': '~15%' }
"let g:fzf_colors = {
"    \'fg' : ['fg', 'Comment'],
"    \'bg+': ['bg', 'Normal'], 'fg+': ['fg', 'Normal'],
"    \'hl+': ['fg', 'Error'], 'hl' : ['fg', 'Error']
"\}

let test#strategy = 'neovim'
let test#neovim#term_position = "belowright 10"


let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_expand_cr = 2

let g:UltiSnipsEditSplit = 'vertical' 

let g:ale_sign_error = '❌'
let g:ale_set_signs = 0
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }


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
set relativenumber
set cursorline

set t_Co=256
set termguicolors
set bg=light
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
set completeopt = ""
set completeopt +=menuone
set omnifunc=syntaxcomplete#Complete

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

" Reload lightline
command! LightlineReload call LightlineReload()

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction


" ================== Other Config =========================================
"source ~/.config/nvim/coc.config.vim

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

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Introduce function text object
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" " Use <TAB> for selections ranges.
" " NOTE: Requires 'textDocument/selectionRange' support from the language server.
" " coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
