return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = "BufReadPost",
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = {
        enable = true,
        disable = {
          -- "vue",
        },
        -- support for these suck in treesitter atm 2023-03-03
        additional_vim_regex_highlighting = {
          "php",
          "vue",
        },
      },
      indent = {
        enable = true,
        disable = {
          -- indent files from the old plugin still works better
          "vue",
        },
      },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "bash",
        "css",
        "scss",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(plugin, opts)
      if plugin.ensure_installed then
        require("lazyvim.util").deprecate("treesitter.ensure_installed", "treesitter.opts.ensure_installed")
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
