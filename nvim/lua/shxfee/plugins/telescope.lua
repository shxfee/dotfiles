if not pcall(require, "telescope") then
    return
end

require('telescope').load_extension('fzy_native')
local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        mappings = {
            i = { ['<c-q>'] = actions.send_to_qflist }
        },
    },
}

local keymap = vim.keymap

keymap.set('n', '<leader>ff', function ()
    return require('telescope.builtin').find_files{previewer=false}
end)

keymap.set('n', '<leader>fd', function ()
    return require('telescope.builtin').find_files{
        find_command = {"fd", "--type", "d"},
        previewer=false
    }
end)

keymap.set('n', '<leader>fg', function ()
    return require('telescope.builtin').live_grep{}
end)

keymap.set('n', '<leader>fc', function ()
    return require('telescope.builtin').colorscheme{}
end)

keymap.set('n', '<leader>fb', function ()
    return require('telescope.builtin').current_buffer_fuzzy_find{}
end)

keymap.set('n', '<leader>fh', function ()
    return require('telescope.builtin').help_tags{}
end)

keymap.set('n', '<leader>fe', function ()
    return require('telescope.builtin').find_files{
        cwd=vim.fn.stdpath('config'),
        previewer=false,
    }
end)

keymap.set('n', '<leader>fp', function ()
    return require('telescope.builtin').find_files{
        find_command = {"fd", "--type", "d"},
        cwd=vim.fn.stdpath('data') .. '/site/pack/packer/',
        previewer=false,
    }
end)
