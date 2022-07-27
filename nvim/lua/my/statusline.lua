vim.opt.showtabline = 0
local theme = require'lualine.themes.nord'

theme.normal.a.bg = '#87afd7'
theme.insert.a.bg = '#afaf87'
theme.normal.b.bg = '#444444'
theme.normal.c.bg = '#585858'

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = theme,
        -- component_separators = { left = '', right = ''},
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {
            {
                'mode',
                fmt = string.lower,
            },
        },
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                path = 1, -- relative
                symbols = {
                    unnamed = '',
                },
            },
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {
            {
                'tabs',
                tabs_color = {
                    active = 'lualine_a_normal',
                    inactive = 'lualine_b_normal',
                },
            },
        },
        -- lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
