local mygroup = vim.api.nvim_create_augroup('vimrc', {clear = true})

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = mygroup,
  desc = "Briefly highlight yanked text",
})

-- resotre cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    if vim.fn.line("'\"") >= 1 and vim.fn.line("'\"") <= vim.fn.line("$") and vim.fn.expand("&ft") ~= 'commit' then
      vim.cmd("normal! g`\"")
    end
  end,
  group = mygroup,
  desc = "Restore cursor position",
})

-- terminal settings because there is no ft for terminal
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.wrap = false
  end,
  group = mygroup,
  desc = "Set terminal options",
})

-- reload config on save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = "**/lua/shxfee/config/*.lua",
  callback = function()
    local filepath = vim.fn.expand("%")

    dofile(filepath)
    vim.notify("Configuration reloaded \n" .. filepath, nil)
  end,
  group = mygroup,
  desc = "Reload config on save",
})
