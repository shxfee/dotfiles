-- github.com/shxfee/
--
-- plugins are managed by lazy.nvim and all specs are in lua/shxfee/plugins
--
-- all configurations are in lua/shxfee/config and supports hot reloading.
-- the config directory contains separate files for options, keymaps, autocmds,
-- commands and abbreviations. customizations.lua is for all customizations
-- that do not fit into the other categories.
--
-- i have borrowed heavily from tjdevries and lazyvim
--
-- references
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim
-- https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim


vim.g.mapleader = " "
vim.g.localleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Lazy automatically loads all specs form the plugins dir
require("lazy").setup({
  spec = {
    { import = "shxfee.plugins" },
    { import = "shxfee.plugins.etc" },
  },
  install = { missing = false },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        -- "matchit",
        "matchparen",
        "netrwPlugin",
        "zipPlugin",
      },
    },
  },
})

-- editor options
require("shxfee.config.options")

-- general keymaps
require("shxfee.config.keymaps")

-- global autocmds
require("shxfee.config.autocmds")

-- custom commands
require("shxfee.config.commands")

-- abbreviations
require("shxfee.config.abbreviations")

-- other customizations
require("shxfee.config.customizations")

-- statuscolumn
-- some errors since updating to 10
-- require("shxfee.config.statuscolumn")
