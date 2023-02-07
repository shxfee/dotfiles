return {
  -- file explorer
  {
    "stevearc/oil.nvim",
    keys = {
      {
        "-",
        function()
          return require("oil").open()
        end,
        desc = "Open file explorer",
      },
    },
    opts = {
      keymaps = {
        ["."] = "actions.open_cmdline",
        ["<C-r>"] = "actions.refresh",
      },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },

    opts = {
      defaults = {
        mappings = {
          i = {
            -- disable tab mapping because it conflicts with copilot
            ["<Tab>"] = false,
            ["<c-q>"] = function()
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
          return require("telescope.builtin").find_files({ previewer = false })
        end,
        desc = "Find files",
      },
      {
        "<leader>fd",
        function()
          return require("telescope.builtin").find_files({
            find_command = { "fd", "--type", "d" },
            previewer = false,
          })
        end,
        desc = "Find directories",
      },
      {
        "<leader>fg",
        function()
          return require("telescope.builtin").live_grep({})
        end,
        desc = "Live grep",
      },
      {
        "<leader>fk",
        function()
          return require("telescope.builtin").colorscheme({})
        end,
        desc = "Find colorscheme",
      },
      {
        "<leader>fh",
        function()
          return require("telescope.builtin").help_tags({})
        end,
        desc = "Find help tags",
      },
      {
        "<leader>fc",
        function()
          return require("telescope.builtin").find_files({
            cwd = vim.fn.stdpath("config"),
            previewer = false,
          })
        end,
        desc = "Find in config dir",
      },
      {
        "<leader>fp",
        function()
          return require("telescope.builtin").find_files({
            find_command = { "fd", "--type", "d" },
            cwd = vim.fn.stdpath("data") .. "/lazy/",
            previewer = false,
          })
        end,
        desc = "Find in plugin dir",
      },
      {
        "<leader>fH",
        function()
          return require("telescope.builtin").highlights({})
        end,
        desc = "Find hightlight group",
      },
    },
  },

  -- leap motion
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        "<Plug>(leap-forward-to)",
        mode = { "n", "v" },
        desc = "Leap forward to",
      },
      {
        "S",
        "<Plug>(leap-backward-to)",
        mode = { "n", "v" },
        desc = "Leap backward to",
      },

      -- using z for operators because s is taken by surround
      {
        "z",
        "<Plug>(leap-forward-to)",
        mode = { "o" },
        desc = "Leap forward to",
      },
      {
        "Z",
        "<Plug>(leap-backward-to)",
        mode = { "o" },
        desc = "Leap backward to",
      }
    },
    config = function(_, opts)
      local leap = require("leap")
    end,
  },

  -- surround
  {
    "kylechui/nvim-surround",
    keys = {
      {"ys"},
      {"ds"},
      {"cs"},
      {"S", mode = "v"},
    },
    config = function()
      require("nvim-surround").setup()
    end,
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
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      popup_mappings = {
        scroll_down = '<c-f>',
        scroll_up = '<c-b>',
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
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>c"] = { name = "+config" },
        ["<leader>t"] = { name = "+test" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>j"] = { name = "+journal" },
        ["<leader>n"] = { name = "+notes" },
      })
    end,
  },

  -- word substitutions for code cases (snake, camel, dot etc)
  {
    "tpope/vim-abolish",
    cmd = "Subvert",
  },
}
