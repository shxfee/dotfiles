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

" ================== !Laravel =================================================
