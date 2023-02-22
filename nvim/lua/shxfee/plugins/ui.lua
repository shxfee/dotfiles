return {
  -- notifications
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>uu",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "clear notifications",
      },
      {
        "<leader>un",
        "<cmd>Notifications<cr>",
        desc = "show notifications",
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
    opts = function()
      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "lazy", "mason" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              color = { gui = 'none' },
              fmt = function(mode)
                return mode:lower()
              end,
            }
          },
          lualine_b = { "branch" },
          lualine_c = {
            { "filename", path = 1, symbols = { modified = "", readonly = "", unnamed = "" } },
          },

          lualine_x = {
            { "diagnostics" },
          },

          lualine_y = {
            { "filetype", icon_only = false, padding = { left = 1, right = 1 } },
            -- minimal tabs in status line
            -- {
            --   'tabs',
            --   tabs_color = {
            --     active = 'lualine_b_normal',
            --     inactive = 'lualine_c_normal',
            --   },
            -- },
          },

          lualine_z = {
            { "progress", padding = { left = 1, right = 1 } },
          },
        },
      }
    end,
  },

  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      char = "│",
      show_end_of_line = true,
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "norg" },
      show_trailing_blankline_indent = false,
    },
  },

  -- icons
  {
    "kyazdani42/nvim-web-devicons",
    event = "VeryLazy",
  },

  -- folding
  {
    "kevinhwang91/nvim-ufo",
    keys = {
      {"z"},
      {
        "zR",
        "<cmd>lua require('ufo').openAllFolds()<cr>",
        desc = "open all folds",
        mode = "n",
      },
      {
        "zM",
        "<cmd>lua require('ufo').closeAllFolds()<cr>",
        desc = "close all folds",
        mode = "n",
      },
    },
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup()
    end
  },

  -- animations
  {
    "echasnovski/mini.animate",
    opts = function()
      local animate = require("mini.animate")

      local options = {
        scroll = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 10, unit = "total" }),
        },

        resize = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 10, unit = "total" }),
        },

        -- Cursor path: janky cursor on NC
        cursor = { enable = false },

        -- Window: janky backgrounds
        open = { enable = false },
        close = { enable = false },
      }

      return options
    end,

    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },

  -- UI for nvim-lsp progress
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      window = {
        relative = "editor",
        blend = 0,
      },
      text = {
        spinner = "dots",
      },
    },
  },
}
