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
    dependencies = {
      "arkav/lualine-lsp-progress",
    },
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
          theme = "OceanicNext",
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
            {
              "diagnostics",
              -- symbols = {
              --   error = icons.diagnostics.Error,
              --   warn = icons.diagnostics.Warn,
              --   info = icons.diagnostics.Info,
              --   hint = icons.diagnostics.Hint,
              -- },
            },
            { "filename", path = 1, symbols = { modified = "", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },

          lualine_x = {
            {
              "lsp_progress",
              display_components = {
                "lsp_client_name", "spinner"
              },
              separators = {
                lsp_client_name = { pre = '', post = '' },
              },
              timer = { spinner = 800 },
              spinner_symbols = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
            },
            -- stylua: ignore
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
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
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },

  -- icons
  {
    "kyazdani42/nvim-web-devicons",
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
}
