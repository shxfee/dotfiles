return {
  -- file manager
  {
    "justinmk/vim-dirvish",
    lazy = false,
  },

  -- fuzzy finder
  -- plugins/etc/telescope.lua
  {
    "nvim-telescope/telescope.nvim",
  },

  -- leap motion
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        "<Plug>(leap-forward-to)",
        mode = { "n", "v" },
        desc = "Leap Forward to",
      },
      {
        "S",
        "<Plug>(leap-backward-to)",
        mode = { "n", "v" },
        desc = "Leap Backward to",
      },

      -- using z for operators because s is taken by surround
      {
        "z",
        "<Plug>(leap-forward-to)",
        mode = { "o" },
        desc = "Leap Forward to",
      },
      {
        "Z",
        "<Plug>(leap-backward-to)",
        mode = { "o" },
        desc = "Leap Backward to",
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
      { "ys" },
      { "ds" },
      { "cs", desc = "Change Surrounding Pair" },

      { "S", mode = "v" },
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

  -- notes
  {
    'MeanderingProgrammer/markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({})
    end,
  }

}
