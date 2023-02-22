return {
  -- file explorer
  {
    "stevearc/oil.nvim",
    lazy = false,
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
      skip_confirm_for_simple_edits = true,
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },

    opts = {
      defaults = {
        layout_config = {
          preview_width = 0.6,
        },
        path_display = {
          truncate = 3,
        },
      },
      pickers = {
        find_files = {
          mappings = {
            n = {
              ["kj"] = "close",
            },
          },
        },
      },
    },

    config = function(_, opts)
      require("telescope").setup(opts)
    end,

    keys = {
      {
        "<leader>fc",
        function()
          return require("telescope.builtin").find_files({
            cwd = vim.fn.stdpath("config"),
          })
        end,
        desc = "Find a Config File",
      },
      {
        "<leader>fd",
        function()
          return require("telescope.builtin").find_files({
            -- find directories using fd ignoring .git
            find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
            previewer = false,
          })
        end,
        desc = "Find a Directory",
      },
      {
        "<leader>ff",
        function()
          return require("telescope.builtin").find_files()
        end,
        desc = "Find a File",
      },
      {
        "<leader>fg",
        function()
          return require("telescope.builtin").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "<leader>fh",
        function()
          return require("telescope.builtin").help_tags()
        end,
        desc = "Find a Help Tag",
      },
      {
        "<leader>fH",
        function()
          return require("telescope.builtin").highlights()
        end,
        desc = "Find a Hightlight Group",
      },
      {
        "<leader>fk",
        function()
          return require("telescope.builtin").colorscheme()
        end,
        desc = "Find a Kolorscheme",
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
        desc = "Find a Plugin File",
      },
      {
        "<leader>fr",
        function()
          return require("telescope.builtin").resume()
        end,
        desc = "Find Resume Last Search",
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
    config = function()
      require("leap")
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
  },

  -- word substitutions for code cases (snake, camel, dot etc)
  {
    "tpope/vim-abolish",
    cmd = "Subvert",
  },
}
