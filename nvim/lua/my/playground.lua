local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g

------------------------------ TEMP -------------------------------------------
-- Figure this shit out yo!
-- TODO extract this function to lua
api.nvim_exec(
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

-- Cheat.sh open scratch buffer
function get_cheat_sh(query)
    if not query or #query == 0 then return end

    -- create buffer
    local buf_name = 'cheat_sh_scratch'
    local buf_nr = fn.bufadd(buf_name)
    local win_id = fn.bufwinid(buf_name)

    -- ensure window exist
    if win_id == -1 then
        cmd('sb '..buf_nr)
        win_id = fn.bufwinid(buf_name)
    end

    -- jump over
    fn.win_gotoid(win_id)

    -- set options
    cmd[[setlocal buftype=nofile bufhidden=hide noswapfile ft=php]]

    -- clear screen
    cmd[[normal ggdG]]

    -- fetch data and read it to buffer
    query = query:gsub(' ', '+')
    print'querying cht.sh...'
    cmd('0read !curl -s cht.sh/'..query..'\\?T')
    cmd[[normal gg]]
end

api.nvim_exec([[ command! -nargs=1 Cheat call luaeval('get_cheat_sh(_A[1])', ['<args>']) ]], false)
