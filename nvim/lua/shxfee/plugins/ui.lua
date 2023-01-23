return {
    -- better vim.notify
    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Delete all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            stages = "static",
        },
        init = function()
            vim.notify = require("notify")
        end,
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "arkav/lualine-lsp-progress",
        },
        init = function ()
            vim.opt.showtabline = 0
        end,
        opts = function ()
            local theme = require'lualine.themes.nord'

            theme.normal.a.bg = '#87afd7'
            theme.insert.a.bg = '#afaf87'
            theme.normal.b.bg = '#444444'
            theme.normal.c.bg = '#585858'

            return {
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
                    lualine_x = {
                        {
                            'lsp_progress',
                            -- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
                            -- With spinner
                            display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
                            -- colors = {
                            --     percentage  = colors.cyan,
                            --     title  = colors.cyan,
                            --     message  = colors.cyan,
                            --     spinner = colors.cyan,
                            --     lsp_client_name = colors.magenta,
                            --     use = true,
                            -- },
                            separators = {
                                component = ' ',
                                progress = ' | ',
                                message = { pre = '(', post = ')'},
                                percentage = { pre = '', post = '%% ' },
                                title = { pre = '', post = ': ' },
                                lsp_client_name = { pre = '[', post = ']' },
                                spinner = { pre = '', post = '' },
                                message = { commenced = 'In Progress', completed = 'Completed' },
                            },
                            display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
                            timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                            spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
                        },
                        'encoding',
                        'fileformat',
                        'filetype'
                    },
                    lualine_y = {
                        {
                            'tabs',
                            tabs_color = {
                                active = 'lualine_b_normal',
                                inactive = 'lualine_c_normal',
                            },
                        },
                    },
                    lualine_z = { 'location' },
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
        end,
    },

    -- indent guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
            show_trailing_blankline_indent = false,
            show_current_context = true,
        },
    },

    -- icons
    {
        "kyazdani42/nvim-web-devicons",
    },

    -- folding
    {
        "anuvyklack/pretty-fold.nvim",
    },
}
