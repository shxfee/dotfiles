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
      a = { ":T ./vendor/bin/sail artisan", "artisan cmd" },
    },
    am = {
      name = "+migrate",
      f = { "<cmd>T ./vendor/bin/sail artisan migrate:fresh --seed<cr>", "fresh" },
    },
  },
  {
    prefix = "<leader>",
    mode = "n",
  }
)

-- window
wk.register({
  w = {
    name = "+window",
    c = { "<cmd>wa<bar>only<bar>enew<cr>", "clear all" },
    m = { "<cmd>WindowsMaximize<cr>", "maximize" },
    a = { "<cmd>WindowsToggleAutowidth<cr>", "auto width toggle" },
  },
}, { prefix = "<leader>", mode = "n" })

-- config
wk.register({
  c = {
    name = "+config",
    c = { "<cmd>vsplit $MYVIMRC<cr>", "edit init.lua" },
    l = { "<cmd>Lazy<cr>", "lazy plugin manager" },
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
