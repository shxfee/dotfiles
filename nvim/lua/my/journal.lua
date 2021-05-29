local fn, cmd = vim.fn, vim.cmd
local telescope = require('telescope.builtin')

local M = {}

local journal_dir = '~/journal'


function M.open_todays_entry()
    local today = '2021-04-24'
    cmd('vsplit')
    cmd('edit ' .. journal_dir .. '/' .. today .. '.md')
end


function M.list_all_entries()
    require('telescope.builtin').find_files({
        cwd = journal_dir;
        find_command = {
            'fd'
        };
    })
end


return M
