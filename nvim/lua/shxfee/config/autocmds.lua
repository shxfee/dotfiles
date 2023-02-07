local mygroup = vim.api.nvim_create_augroup("vimrc", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = mygroup,
  desc = "Briefly highlight yanked text",
})

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

-- transparent backgrounds
vim.api.nvim_create_autocmd({"VimEnter", "Colorscheme"}, {
  callback = function ()
    local groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "Float",
      "FloatBorder",
      "SignColumn",
      "GitSignsAdd",
      "GitSignsChange",
      "GitSignsDelete",
      "Pmenu",
      "PmenuSel",
      "WinSeparator",
      "TelescopeNormal",
      "TelescopeBorder",
      "TelescopeSelection",
      "TelescopePreviewNormal",
      "WhichKeyFloat",
    }

    for _, group in ipairs(groups) do
      -- :hi Comment ctermfg=Cyan ctermbg=None guifg=#80a0ff gui=bold
      vim.cmd("hi " .. group .. " ctermbg=None guibg=NONE")
    end

    -- dim fg for WinSeparator
    vim.cmd("hi WinSeparator guifg=#4e4d5e")
  end,
  group = mygroup,
  desc = "Transparent backgrounds",
})
