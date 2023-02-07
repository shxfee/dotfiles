-- github.com/shxfee/
--
-- plugins are managed by lazy.nvim and all specs are in lua/shxfee/plugins
--
-- all configurations are in lua/shxfee/config and supports hot reloading.
-- the config directory contains separate files for options, keymaps, autocmds,
-- commands and abbreviations. customizations.lua is for all customizations
-- that do not fit into the other categories.
--
-- filetype configurations are in after/ftplugin. they set buffer local options
-- for different filetypes like shiftwidth, tabstop, etc.
--
-- i have borrowed heavily from tjdevries and lazyvim
--
-- references
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim
-- https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim


vim.g.mapleader = " "

-- Plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy automatjcally loads all files form plugins dir
require("lazy").setup("shxfee.plugins", {
  install = { colorscheme = { "nordic" }, missing = false },
  ui = {
    border = "rounded",
    performance = {
      rtp = {
        disabled_plugins = { "netrwPlugin" },
      },
    },
  }
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
