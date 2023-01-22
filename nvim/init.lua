-- github.com/shxfee/
-- Plugins are managed by Lazy.nvim and all specs are in lua/shxfee/plugins
-- Other configurations are in lua/shxfee/config and supports hot reloading
-- check autocmds.lua for more details
-- I have borrowed heavily from tjdevries and LazyVim

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

-- Lazy automatically loads all files form plugins dir
require("lazy").setup( "shxfee.plugins", { ui = { border = "rounded" } })


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
