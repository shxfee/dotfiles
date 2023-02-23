return {
  -- split/join code blocks
  {
    "Wansmer/treesj",
    opts = {
      use_default_keymaps = false,
      max_join_length = 200,
    },
    keys = {
      { "gs", "<Cmd>TSJSplit<CR>", "Split Code" },
      { "gj", "<Cmd>TSJJoin<CR>", "Join Code" },
    },
  },

  -- chatgpt
  {
    "jackMort/ChatGPT.nvim",
    opts = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "ChatGPT",
  },

  -- simple todo
  {
    "nocksock/do.nvim",
    opts = {
      message_timeout = 2000, -- how long notifications are shown
      kaomoji_mode = 0, -- 0 kaomoji everywhere, 1 skip kaomoji in doing
      winbar = true,
      doing_prefix = "Doing: ",
      store = {
        auto_create_file = true, -- automatically create a .do_tasks when calling :Do
        file_name = ".do_tasks",
      }
    },
    cmd = { "Do", "DoEdit", "DoShow" },
  },

  -- duck
  {
    "tamton-aquib/duck.nvim",
    name = "duck",
    keys = {
      {
        "<leader>ud",
        function ()
          require("duck").hatch("🦀", 0.75)
        end
      },
    },
  },

  -- refactoring code
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter",
    },
    keys = {
      {
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        mode = "v",
        desc = "Extract function"
      },
      {
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        mode = "v",
        desc = "Extract function to file",
      },
      {
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        mode = "v",
        desc = "Extract variable",
      },
      {
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        mode = "v",
        desc = "Inline variable",
      },
    }
  },

  -- bracket navigation
  {
    'echasnovski/mini.bracketed',
    enabled = true,
    event = "VeryLazy",
    version = false,
    config = function ()
      require("mini.bracketed").setup()
    end
  },

  -- fuzzy finder 2.0
  {
    "ibhagwan/fzf-lua",
    enabled = true,
    dependencies = { 'nvim-web-devicons' },
    opts = {
      files = {
        git_icons = false,
      },
    },
    keys = {
      {
        "<leader>pp",
        function()
          return require("fzf-lua").files()
        end,
        desc = "Find a File",
      },
      {
        "<leader>pd",
        function()
          return require("fzf-lua").files({
            -- find directories using fd ignoring .git
            cmd = "fd --type d --hidden --exclude .git",
          })
        end,
        desc = "Find a Directory",
      },
    },
  },

  -- orgmode
  {
    "nvim-orgmode/orgmode",
    build = function()
      require('orgmode').setup_ts_grammar()
      vim.cmd("TSUpdate org")
    end,
    dependencies = {
      {
        "nvim-treesitter",
        opts = function(_, opts)
          local newOpts = {
            highlight = {
              additional_vim_regex_highlighting = { 'org' }
            },
            ensure_installed = { 'org' },
          }

          return vim.tbl_deep_extend("force", opts, newOpts)
        end,
      },
      {
        "nvim-cmp",
        opts = function(_, opts)
          local newOpts = {
            sources = {
              { name = 'orgmode' },
            },
          }

          return vim.tbl_deep_extend("force", opts, newOpts)
        end,
      },
    },
    opts = {
      org_agenda_files = { '~/documents/org/*' },
      org_default_notes_file = '~/documents/org/refile.org',
    },
    config = function(_, opts)
      local org = require('orgmode')

      org.setup_ts_grammar()
      org.setup(opts)
    end,
  },
}
