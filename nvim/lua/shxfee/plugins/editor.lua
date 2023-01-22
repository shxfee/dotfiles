return {
    -- file explorer
    {
        "justinmk/vim-dirvish",
        init = function()
            -- sort directories first
            vim.g.dirvish_mode = [[:sort ,^.*[\/],]]
        end,
    },

    -- some useful keymaps from tpope
    {
        "tpope/vim-unimpaired",
        lazy = false,
    },

    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        dependencies = {
            "nvim-telescope/telescope-fzy-native.nvim",
        },

        opts = {
            defaults = {
                mappings = {
                    i = {
                        -- disable tab mapping because it conflicts with copilot
                        ['<Tab>'] = false,
                        ['<c-q>'] = function()
                            require("telescope.actions").send_to_qflist()
                        end,
                    },
                },
            },
        },
        keys = {
            {
                "<leader>ff",
                function()
                    return require('telescope.builtin').find_files{ previewer=false }
                end,
                desc = "Find files"
            },
            {
                "<leader>fd",
                function()
                    return require('telescope.builtin').find_files{
                        find_command = {"fd", "--type", "d"},
                        previewer=false
                    }
                end,
                desc = "Find directories",
            },
            {
                "<leader>fg",
                function()
                    return require('telescope.builtin').live_grep{}
                end,
                desc = "Live grep",
            },
            {
                "<leader>fc",
                function()
                    return require('telescope.builtin').colorscheme{}
                end,
                desc = "Find colorscheme",
            },
            {
                "<leader>fh",
                function()
                    return require('telescope.builtin').help_tags{}
                end,
                desc = "Find help tags",
            },
            {
                "<leader>fe",
                function()
                    return require('telescope.builtin').find_files{
                        cwd=vim.fn.stdpath('config'),
                        previewer=false,
                    }
                end,
                desc = "Find in config/env dir",
            },
            {
                "<leader>fp",
                function ()
                    return require('telescope.builtin').find_files{
                        find_command = {"fd", "--type", "d"},
                        cwd=vim.fn.stdpath('data') .. '/lazy/',
                        previewer=false,
                    }
                end,
                desc = "Find in plugin dir",
            },
        },
    },

    -- which-key
    {
        "folke/which-key.nvim",
        lazy = false,
        config = function()
            require("which-key").setup {
                plugins = {
                    spelling = {
                        enabled = true,
                        suggestions = 20,
                    },
                },
            }
        end,
    },

}
