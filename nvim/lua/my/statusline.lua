local fn, cmd = vim.fn, vim.cmd

------------------------------ STATUSLINE -------------------------------------
function my_statusline()
    local branch = fn.FugitiveHead()

    if branch and #branch > 0 then
        branch = '  '..branch

        if vim.o.paste then
            branch = branch .. ' [PASTE]'
        end
    end 

    return branch..'  %f%m%=%{&ft} %l:%c '
end

cmd[[ set statusline=%!luaeval('my_statusline()') ]]


------------------------------ TAB LINE ---------------------------------------
function my_tabline()
    local s = ''
    for i = 1, fn.tabpagenr('$') do
        if i == fn.tabpagenr() then s = s .. '%#TabLineSel#'
        else s = s .. '%#TabLine#' end
        s = s .. ' Tab ' .. i .. ' '
    end

    s = s .. '%#TabLineFill#%T'
    return s
end

cmd[[ set tabline=%!luaeval('my_tabline()') ]]
