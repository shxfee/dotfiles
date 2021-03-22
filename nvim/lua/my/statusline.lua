local utils = require('my.utils')
local vim = vim
local execute = vim.api.nvim_exec

-- execute(
-- [[
--   hi MyStatusLineLight guibg=#585858 guifg=white
--   hi MyStatusLineDark guibg=#303030 guifg=#b2b2b2

--   hi TabLine guibg=#303030 guifg=#b2b2b2
--   hi TabLineFill guibg=#303030 guifg=#b2b2b2
--   hi TabLineSel guibg=#585858 guifg=white
-- ]], false)

execute(
[[
  hi StatusLine guibg=#303030 guifg=#c6c6c6
  hi StatusLineNC guibg=#262626	 guifg=#444444

  hi TabLine guibg=#303030 guifg=#b2b2b2
  hi TabLineFill guibg=#303030 guifg=#b2b2b2
  hi TabLineSel guibg=#585858 guifg=white
]], false)


local statusline = {
    -- '%#MyStatusLineLight#', 
    ' %{FugitiveHead()} ',
    -- '%#MyStatusLineDark#',
    ' %f ',
    '%m ',
    '%=', 
    '%{&filetype} ',
    -- '%#MyStatusLineLight#',
    ' %p%% ',
}

vim.o.statusline = table.concat(statusline)


-- Temporary building status line attempt 2

function status_line()
    local branch = fn.FugitiveHead()
    local icon = ''
    local icon_branch = ''

    if branch then
        icon_branch = ' ' .. icon .. ' ' .. branch
    end

    local stl = {
        icon_branch,
        '  %f',
        '%m',
        '%=',
        '%l,%c ',
        '%{&filetype} ',
    }

    return  table.concat(stl)
end

opt('o', 'statusline', status_line())
