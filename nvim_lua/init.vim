" =============================================================================
"                       NeoVim Configuration
" =============================================================================

source <sfile>:h/functions.vim
luafile <sfile>:h/functions.lua
luafile <sfile>:h/moving.lua


" ================== Plugin Setup =============================================

let g:lightline = { 'active': {}, 'inactive': {}, 'component_function': {} }
let g:lightline.colorscheme = 'google'
let g:lightline.active.left = [['paste'], ['git'], ['filename', 'modified']]
let g:lightline.active.right = [['percent'], ['line'], ['filetype'], ['readonly']]
let g:lightline.inactive.left = []
let g:lightline.component_function.git = 'fugitive#head'
let g:lightline.component_function.filename = 'LightlineFilename'


" ================== Key bindings =============================================
nnoremap <SPACE> <Nop>
let mapleader=" "

" Primary leader maps
nnoremap <leader>d  :Dirs<cr>
nnoremap <leader>f  :Files<cr>
nnoremap <leader>gg :vertical Git<cr>

" Window leader maps
nnoremap <leader>wc :wa<cr>:only<cr>:enew<cr>

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

nnoremap <silent> <leader>tt :<c-u>call v:lua.runNearestOrLastTest()<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>

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
nnoremap <silent> K :call v:lua.openDocumentation()<CR>

" Add count jumps to jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>



" ================== Commands =================================================
command! -bang Files
    \ call fzf#run(fzf#wrap('my-files', {'source': 'fd --type f --hidden', 'options': '--inline-info'}, <bang>0))

command! -bang Dirs
    \ call fzf#run(fzf#wrap('my-dirs', {'source': 'fd --type d --hidden', 'options': '--inline-info'}, <bang>0))

command! -nargs=* T 10split | startinsert | terminal <args>


" ================== Auto commands ============================================
augroup general
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.js,*.vue,*.blade.php setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufNewFile,BufRead *.blade.php setlocal ft=blade shiftwidth=2 tabstop=2 softtabstop=2

    " silent create all required directories for file
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    autocmd VimEnter * silent! call SetGlobalDadbodDBString()
augroup END


augroup reload_config
    autocmd!
    autocmd BufWritePost init.vim  source $MYVIMRC
    autocmd BufWritePost init.vim  call lightline#colorscheme()
augroup END


augroup term_options
    autocmd!
    autocmd FileType fzf set laststatus=0 signcolumn=no
      \| autocmd BufLeave <buffer> set laststatus=2 signcolumn=yes

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
