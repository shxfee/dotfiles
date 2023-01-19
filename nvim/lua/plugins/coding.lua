-- TODO: windwp/nvim-ts-autotag
-- TODO: L3MON4D3/LuaSnip

return {
    -- snippets
    {
        'hrsh7th/vim-vsnip',
        init = function()
            vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnip'
        end,
    },

    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "onsails/lspkind.nvim",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                window = {
                    completion = {
                        border = 'rounded',
                        winhighlight = 'Normal:Pmenu,FloatBorder:Normal,CursorLine:PmenuSel,Search:None',
                    },
                    documentation = { border = 'rounded', }
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<c-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = require'lspkind'.cmp_format{
                        with_text = true,
                        menu = {
                            nvim_lsp = '[lsp]',
                            vsnip = '[snip]',
                            neorg = '[norg]',
                            buffer = '[buf]',
                            path = '[path]',
                        },

                    },
                },
                experimental = {
                    ghost_text = false,
                },
            }
        end,
    },

    -- auto pairs
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },

    -- tabularize lines of code
    {
        "godlygeek/tabular",
        cmd = "Tabularize",
    },

    -- surround
    {
        "echasnovski/mini.surround",
        keys = function(plugin, keys)
            -- Populate the keys based on the user's options
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local mappings = {
                { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
                { opts.mappings.delete, desc = "Delete surrounding" },
                { opts.mappings.find, desc = "Find right surrounding" },
                { opts.mappings.find_left, desc = "Find left surrounding" },
                { opts.mappings.highlight, desc = "Highlight surrounding" },
                { opts.mappings.replace, desc = "Replace surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
            }
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "sa", -- Add surrounding in Normal and Visual modes
                delete = "ds", -- Delete surrounding
                find = "sf", -- Find surrounding (to the right)
                find_left = "sF", -- Find surrounding (to the left)
                highlight = "sh", -- Highlight surrounding
                replace = "cs", -- Replace surrounding
                update_n_lines = "sn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            -- use gz mappings instead of s to prevent conflict with leap
            require("mini.surround").setup(opts)
        end,
    },

    -- word substitutions for code cases (snake, camel, dot etc)
    {
        "tpope/vim-abolish",
        cmd = "Subvert",
    },

    -- comments
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            hooks = {
                pre = function()
                    require("ts_context_commentstring.internal").update_commentstring({})
                end,
            },
        },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },

    -- better text-objects
    {
        "echasnovski/mini.ai",
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
        },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- no need to load the plugin, since we only need its queries
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                end,
            },
        },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
        config = function(_, opts)
            local ai = require("mini.ai")
            ai.setup(opts)
        end,
    },

    -- preview colors
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = {
                '*';
                '!neorg';
            }
        },
    },

    -- test
    {
        "janko-m/vim-test",
        init = function()
            vim.g["test#strategy"] = "neovim"
            vim.g["test#neovim#term_position"] = "split"
            vim.g["test#php#phpunit#executable"] = "./vendor/bin/phpunit"
        end,
        keys = {
            {
                "<leader>tt",
                function ()
                    require("shxfee.utils").run_nearest_or_last_test()
                end,
                desc = "Run the current test case",
            },
            {
                "<leader>tf",
                "<cmd>TestFile<cr>",
                desc = "Run all tests in file",
            },
            {
                "<leader>tl",
                "<cmd>TestLast<cr>",
                desc = "Run last test",
            },
            {
                "<leader>ts",
                "<cmd>TestSuite<cr>",
                desc = "Run test suite",
            },
        },
    },

    -- git
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            {
                "<leader>gg",
                "<cmd>vertical Git<cr>",
                desc = "Git status",
            },
            {
                "<leader>gb",
                "<cmd>0GlLog!<cr>",
                desc = "Git log for current buffer",
            },
        },
    },
}
