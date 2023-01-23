return {
    -- file explorer
    {
        "justinmk/vim-dirvish",
        init = function()
            -- sort directories first
            vim.g.dirvish_mode = [[:sort ,^.*[\/],]]
        end,
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
        opts = {
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
            },
            window = {
                border = "single",
                position = "bottom",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)

            wk.register({
                mode = { "n", "v" },
                ["<leader>a"] = { name = "+artisan" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>w"] = { name = "+window" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>c"] = { name = "+config" },
                ["<leader>t"] = { name = "+test" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>j"] = { name = "+journal" },
                ["<leader>n"] = { name = "+notes" }
            })
        end,
    },

}
