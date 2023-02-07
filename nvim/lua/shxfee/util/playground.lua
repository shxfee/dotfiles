------------------------------ TEMP -------------------------------------------
-- Figure this shit out yo!
-- TODO extract this function to lua
vim.api.nvim_exec(
  [[
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
    ]], false
)

vim.api.nvim_exec([[ command! -nargs=1 Cheat call luaeval('get_cheat_sh(_A[1])', ['<args>']) ]], false)
