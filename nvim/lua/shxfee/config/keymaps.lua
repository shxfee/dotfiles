local keymap = vim.keymap
local wk = require("which-key")

-- leader mappings
wk.register(
  {
    -- artisan
    a = {
      name = "+artisan",
      c = {
        function ()
          local cmd = ":T ./vendor/bin/sail artisan "
          vim.api.nvim_feedkeys(cmd, "n", true)
        end,
        "Artisan Cmd"
      },
    },

    am = {
      name = "+migrate",
      f = {
        "<cmd>T ./vendor/bin/sail artisan migrate:fresh --seed<cr>",
        "Artisan Migrate Fresh",
      },
    },

    -- configuration
    c = {
      name = "+config",
      -- edit autocmds.lua
      a = {
        function ()
          local config_dir = vim.fn.stdpath("config")
          vim.cmd.edit(config_dir .. "/lua/shxfee/config/autocmds.lua")
        end,
        "Config Autocommands",
      },
      -- the one I am 
      c = {
        function ()
          local config_dir = vim.fn.stdpath("config")
          vim.cmd.edit(config_dir .. "/lua/shxfee/plugins/editor.lua")
        end,
        "Config Config I am Editing",
      },
      d = {
        function ()
          local config_dir = vim.fn.stdpath("config")
          vim.cmd.edit(config_dir)
        end,
        "Config Directory",
      },
      f = {
        function ()
          require("telescope.builtin").find_files({
            prompt_title = "Config Files",
            cwd = vim.fn.stdpath("config"),
          })
        end,
        "Config Files",
      },
      k = {
        -- edit keymaps.lua
        function ()
          local config_dir = vim.fn.stdpath("config")
          vim.cmd.edit(config_dir .. "/lua/shxfee/config/keymaps.lua")
        end,
        "Config Keymaps",
      },
      l = { "<cmd>Lazy<cr>", "Config Lazy" },
      n = {
        function ()
          local config_dir = vim.fn.stdpath("config")
          vim.cmd.edit(config_dir .. "/notes.norg")
        end,
        "Config Notes",
      },
      o = {
        -- edit options.lua
        function ()
          local config_dir = vim.fn.stdpath("config")
          vim.cmd.edit(config_dir .. "/lua/shxfee/config/options.lua")
        end,
        "Config Options",
      },
    },

    -- find/files
    -- defined in telescope spec
    f = { name = "+file/find" },

    -- git
    g = {
      name = "+git",
      l = { "<cmd>tabe<bar>terminal lazygit<cr>", "Lazygit" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View" },
      g = { "<cmd>vert Git<cr>", "Git" },
    },

    -- notes
    -- defined in neorg spec
    n = { name = "+notes" },

    -- quit
    q = { "<cmd>q<cr>", "Quit" },

    -- test
    -- defined in test spec
    t = { name = "+test" },

    -- ui
    u = {
      name = "+ui",
      r = {
        function ()
          -- reset colorscheme
          local c = vim.cmd.colorscheme()
          vim.cmd.colorscheme(c)
        end,
        "UI Refresh",
      },
    },

    -- window
    w = {
      name = "+window",
      c = { "<cmd>wa<bar>only<bar>%bdelete<bar>enew<cr>", "Windows Clear All" },
    },

    -- save and quit
    x = { "<cmd>x<cr>", "Save & Quit" },

    -- special maps
    ["<tab>"] = {
      name = "+tabs",
      ["<tab>"] = { "<cmd>tabe<cr>", "Tab New" },
    },
  },

  { prefix = "<leader>" }
)


-- other mappings
-- easier command history navigation
keymap.set("c", "<c-p>", "<up>")
keymap.set("c", "<c-n>", "<down>")

-- escape terminal mode with <c-o>
keymap.set("t", "<c-o>", "<c-\\><c-n>")

-- copy paste from system clipboard
keymap.set("v", "<a-y>", '"+y')
keymap.set("n", "<a-p>", '"+]p')
keymap.set("v", "<a-p>", '"+]p')
keymap.set("i", "<a-p>", "<c-r>+")

-- paste last yanked text
keymap.set("n", "gp", '"0p', { desc = "Paste Last Yanked Text" })

-- open links in browser
keymap.set(
  "n", "gl",
  [[:execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>]],
  { silent = true }
)

-- better up/down
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- always search forward with n and back with N
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- save file in all modes
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
