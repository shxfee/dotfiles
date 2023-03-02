return {
  {
    "telescope.nvim",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
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
      require('telescope').load_extension('fzy_native')
      require("telescope").load_extension("live_grep_args")
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
          return require("telescope").extensions.live_grep_args.live_grep_args()
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
          return require("telescope.builtin").keymaps()
        end,
        desc = "Find a keymap",
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
  }
}
