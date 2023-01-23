return {
  -- snippets
  {
    'hrsh7th/vim-vsnip',
    init = function()
      vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnip'
      vim.cmd[[imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']]
      vim.cmd[[smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']]
      vim.cmd[[imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>']]
      vim.cmd[[smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>']]
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
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "cs", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
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

  -- refactoring code
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter",
    },
    keys = {
      {
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        mode = "v",
        desc = "Extract function"
      },
      {
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        mode = "v",
        desc = "Extract function to file",
      },
      {
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        mode = "v",
        desc = "Extract variable",
      },
      {
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        mode = "v",
        desc = "Inline variable",
      },
    }
  },

  -- auto html tag completion
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
