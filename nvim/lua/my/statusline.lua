local vim, fn, cmd = vim, vim.fn, vim.cmd

------------------------------ STATUSLINE -------------------------------------
function My_statusline()
    local branch = fn.FugitiveHead()

    if branch and #branch > 0 then
        branch = '  '..branch

        if vim.o.paste then
            branch = branch .. ' [PASTE]'
        end
    end

    local sl = branch..'  %f%m%=%{&ft} '

    sl = sl..' %#StatusLine# %l:%c '
    return sl
end

cmd[[ set statusline=%!luaeval('My_statusline()') ]]



------------------------------ TAB LINE ---------------------------------------
function My_tabline()
    local s = ''

    for i = 1, fn.tabpagenr('$') do
        local buflist = fn.tabpagebuflist(i)
        local label = fn.bufname(buflist[1])
        label = ' ' .. fn.fnamemodify(label, ':t')

        if label == ' ' then label = '[No Name]' end

        if i == fn.tabpagenr() then s = s .. '%#TabLineSel#'
        else s = s .. '%#TabLine#' end
        s = s .. label .. ' '
    end

    s = s .. '%#TabLineFill#%T'
    return s
end

cmd[[ set tabline=%!luaeval('My_tabline()') ]]
