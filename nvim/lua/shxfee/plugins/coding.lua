return {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    version = "1.2",
    build = function()
      local Util = require("lazy.core.util")

      -- check if make is avaialble
      if vim.fn.executable("make") == 0 then
        Util.warn(
          "make is not available, jsregex will not be available",
          { title = "LuaSnip" }
        )
        return
      end

      -- check if luajit is available
      if vim.fn.executable("luajit") == 0 then
        Util.warn(
          "luajit is not available, jsregex will not be available",
          { title = "LuaSnip" }
        )
        return
      end

      vim.fn.system("make install_jsregex")
    end,
    opts = {
      history = true,
      delete_check_event = "TextChanged",
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
        desc = "git status",
      },
      {
        "<leader>gb",
        "<cmd>0GlLog!<cr>",
        desc = "git log for buffer",
      },
      {
        "<leader>gp",
        "<cmd>Git push<cr>",
        desc = "git push",
      }
    },
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "│" },
        topdelete = { text = "│" },
        changedelete = { text = "│" },
        untracked = { text = "│" },
        -- add = { text = "▎" },
        -- change = { text = "▎" },
        -- delete = { text = "▎" },
        -- topdelete = { text = "▎" },
        -- changedelete = { text = "▎" },
        -- untracked = { text = "▎" },
      },
    },
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = {
      {
        "gc",
        mode = { "n", "v" },
        desc = "Comment",
      },
    },
    opts = {
      pre_hook = function()
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      end,
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
    end,
  },

  -- auto html tag completion
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- tabularize lines of code
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },

  -- preview colors
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "html", "sass", "scss", "vue" },
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

  -- keeping track of time
  {
    "wakatime/vim-wakatime",
  },

  -- copilot lua
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-j>",
          accept_line = "<M-l>",
          accept_word = "<M-k>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<M-c>",
        },
      },
    },
  },
}
