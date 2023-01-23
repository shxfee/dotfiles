return {
  -- better vim.notify
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
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
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
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
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
            },
            -- stylua: ignore
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
          },
          lualine_y = {
            {
              "diff",
              padding = { left = 1, right = 1 },
              -- symbols = {
              --   added = icons.git.added,
              --   modified = icons.git.modified,
              --   removed = icons.git.removed,
              -- },
            },
          },

          lualine_z = {
            { "progress", separator = " ", padding = { left = 1, right = 1 } },
          },
        },
      }
    end,
  },

  -- indent guides for Neovim
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
    "anuvyklack/pretty-fold.nvim",
  },
}
