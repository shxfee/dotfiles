return {
  -- git fugitive
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
    opts = function ()
      local opts = {}

      -- slim │ fat ▎
      local char = "│"

      opts["signs"] = {
        add = { text = char },
        change = { text = char },
        delete = { text = char },
        topdelete = { text = char },
        changedelete = { text = char },
        untracked = { text = char },
      }

      return opts
    end,
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "DiffviewOpen",
    opts = true,
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
