return {
  {
    "shxfee/nord-vim",
    enabled = false,
    priority = 1000,
    -- config = function ()
    --   vim.cmd([[colorscheme nord]])
    -- end
  },

  {
    "andersevenrud/nordic.nvim",
    enabled = true,
    priority = 1000,
    config = function ()
      vim.g.nord_underline_option = 'none'
      vim.g.nord_italic = false
      vim.g.nord_italic_comments = false
      vim.g.nord_minimal_mode = false
      vim.g.nord_alternate_backgrounds = false

      vim.cmd([[colorscheme nordic]])
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    lazy = true,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        styles = {
          comments = { "italic" },
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = true,
          mini = false,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
    end
  },
}
