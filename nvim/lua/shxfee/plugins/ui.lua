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
            {
              function ()
                -- get the first lsp client that is attached to the current buffer
                local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                local ignored_clients = {
                  "diagnosticls",
                  "copilot",
                  "null-ls",
                }

                if #clients == 0 then
                  return ""
                end

                -- find the first client that is not ignored
                for _, client in ipairs(clients) do
                  if not vim.tbl_contains(ignored_clients, client.name) then
                    return client.name
                  end
                end

                return ""
              end
            },
            { "diagnostics" },
          },

          lualine_y = {
            { "filetype", icon_only = false, padding = { left = 1, right = 1 } },
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
      -- char = "┊",
      -- char = "⁞",
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
