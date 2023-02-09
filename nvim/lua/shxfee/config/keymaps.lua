local keymap = vim.keymap
local wk = require("which-key")

-- main
wk.register(
  {
    q = { "<cmd>q<cr>", "Quit" },
    x = { "<cmd>x<cr>", "Save & Quit" },
  },
  {
    prefix = "<leader>",
    mode = "n",
    nowait = true,
  }
)

-- artisan
wk.register(
  {
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
  },
  {
    prefix = "<leader>",
    mode = "n",
    nowait = true,
  }
)

-- window
wk.register({
  w = {
    name = "+window",
    c = { "<cmd>wa<bar>only<bar>%bdelete<bar>enew<cr>", "Windows Clear All" },
  },
}, { prefix = "<leader>", mode = "n" })

-- config
wk.register({
  c = {
    name = "+config",
    d = {
      function ()
        local config_dir = vim.fn.stdpath("config")
        vim.cmd.edit(config_dir)
      end,
      "Config Directory",
    },
    e = { "<emd>vsplit $MYVIMRC<er>", "Config Edit" },
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
}, { prefix = "<leader>", mode = "n" })

-- ui
keymap.set(
  "n", 
  "<leader>ur",
  function ()
    vim.cmd.colorscheme("nordic")
  end,
  { desc = "reload ui" }
)


keymap.set("c", "<c-p>", "<up>")
keymap.set("c", "<c-n>", "<down>")

-- tabs
keymap.set("n", "<leader><tab><tab>", "<cmd>tabe<cr>", { desc = "new tab" })


-- require("lazy.util").float_term(cmd, opts)
-- git
keymap.set(
  "n",
  "<leader>gg",
  function()
    require("lazy.util").float_term(
      { "lazygit" },
      { size = { width = 0.9, height = 0.85 } }
    )
  end,
  { desc = "Lazygit" }
)

keymap.set("t", "<c-o>", "<c-\\><c-n>")

keymap.set("v", "<a-y>", '"+y')
keymap.set("n", "<a-p>", '"+p')
keymap.set("v", "<a-p>", '"+p')
keymap.set("i", "<a-p>", "<c-r>+")

keymap.set("n", "gV", "`[v`]")

-- open links in browser
keymap.set("n", "gl", [[:execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>]], { silent = true })
