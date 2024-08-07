local mygroup = vim.api.nvim_create_augroup("vimrc", { clear = true })


-- resotre cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.fn.line("'\"") >= 1 and vim.fn.line("'\"") <= vim.fn.line("$") and vim.fn.expand("&ft") ~= "commit" then
      vim.cmd('normal! g`"')
    end
  end,
  group = mygroup,
  desc = "Restore cursor position",
})

-- terminal settings because there is no ft for terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.statuscolumn = ""
    vim.cmd.startinsert()
  end,
  group = mygroup,
  desc = "Set terminal options",
})

-- reload config on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "**/lua/shxfee/config/*.lua",
  callback = function()
    local filepath = vim.fn.expand("%")

    dofile(filepath)
    vim.notify("Configuration reloaded \n" .. filepath, nil, {
      title = "autocmds.lua",
    })
  end,
  group = mygroup,
  desc = "Reload config on save",
})

-- autoformat code on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.php", "*.vue", "*.js", "*.ts", "*.tsx", "*.json", "*.css",
    "*.scss", "*.html"
  },
  callback = function()
    -- noop if no lsp
    vim.lsp.buf.format()
  end,
  group = mygroup,
  desc = "Autoformat code on save",
})

-- disable diagnostics for .env files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".env",
  callback = function()
    vim.diagnostic.disable()
  end,
  group = mygroup,
  desc = "Disable diagnostics for .env files",
})
