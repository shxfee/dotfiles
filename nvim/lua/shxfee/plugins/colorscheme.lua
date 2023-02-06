return {
  {
    "xiyaowong/nvim-transparent",
    name = "nvim-transparent",
    opts = {
      enable = true;
      extra_groups = {
        'WinSeparator',
        'VertSplit',
        'TabLine',
        'TabLineFill',
        'Pmenu',
        'PmenuSel',
        'Folded',
      };
    }
  },

  {
    "shxfee/nord-vim",
    dependencies = {
      { "nvim-transparent", lazy = false }, 
    },
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd([[ colorscheme nord]])
    end
  },

  {
    "shxfee/oceanic-next-vim",
    lazy = true,
  },

  {
    "kyazdani42/blue-moon",
    lazy = true,
  },

  {
    "Th3Whit3Wolf/one-nvim",
    lazy = true,
  },
}
