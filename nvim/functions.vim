" Generate a filename from project root for lightline
function! LightlineFilename() abort
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction


" Show documentation for CoC
function! ShowDocumentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Floating window for FZF
function! CreateCenteredFloatingWindow() abort
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction


" Get Syntax Group under cursor
function! SynGroup() abort
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction


" ================== Laravel ==================================================
" Read laravel .env
function! LaravelEnvironment() abort
    " Check for the existance of the .env file in cd
    try
        let fname = './.env'
        return readfile(fname)
    catch
        echoerr "An .env file not found in pwd"
    endtry
endfunction

function! LaravelDBConnectionString() abort
    " Get environment
    let l:dbUser = ''
    let l:dbPass = ''
    let l:dbName = ''
    let env = LaravelEnvironment()

    for item in env
        let conf = split(item, '=')
        let key = get(conf, 0)
        let value = get(conf, 1)

        if (key != "" && 'DB_DATABASE' == key)
            let l:dbName = value
        elseif (key != "" && 'DB_PASSWORD' == key)
            let l:dbPass = value
        elseif (key != "" && 'DB_USERNAME' == key)
            let l:dbUser = value
        endif
    endfor

    if (dbUser != '' && dbPass != '' && dbName != '')
        return 'mysql://' .. dbUser .. ':' .. dbPass .. '@localhost/' .. dbName
    else
        echo dbUser .. dbPass .. dbName
        echoerr 'Database config missing from .env'
    endif
endfunction

function! LaravelDBTables() abort
    execute "DB " .. LaravelDBConnectionString() .. " SHOW TABLES"
endfunction

function! LaravelDBDescribe(table) abort
    execute "DB " .. LaravelDBConnectionString() .. " DESCRIBE " .. a:table
endfunction

function! LaravelDBView(table) abort
    execute "DB " .. LaravelDBConnectionString() .. " SELECT * FROM " .. a:table .. " LIMIT 10"
endfunction

command! -nargs=1 Dbd call LaravelDBDescribe(expand("<args>"))
command! -nargs=1 Dbv call LaravelDBView(expand("<args>"))
command! Dbl call LaravelDBTables()


function! SetGlobalDadbodDBString() abort
    try
        let g:db = LaravelDBConnectionString()
    catch
        " Ignore errors
    endtry
endfunction

" Run the nearest test if in a test file
" Otherwise run the last test
function! RunNearestOrLastTest() abort
    if @% =~ 'Test.*$'
        execute "TestNearest"
    else
        execute "TestLast"
    endif
endfunction

" ================== !Laravel =================================================
