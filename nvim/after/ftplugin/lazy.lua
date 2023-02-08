vim.opt_local.number = false
vim.opt_local.relativenumber = false

-- quit keymaps
vim.keymap.set(
  "n",
  "gq",
  "<cmd>q<cr>",
  { buffer = true }
)
