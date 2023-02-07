return {
  {
    "shxfee/nord-vim",
    lazy = true,
    priority = 1000,
    -- config = function ()
    --   vim.cmd([[colorscheme nord]])
    -- end
  },

  {
    "andersevenrud/nordic.nvim",
    lazy = false,
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
}
