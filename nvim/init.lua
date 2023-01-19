-- neovim config
-- github.com/shxfee

vim.g.mapleader = " "

------------------------------ PLUGINS ----------------------------------------

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
require("lazy").setup("plugins", { ui = { border = "rounded" }})


------------------------------ OPTIONS ----------------------------------------
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/options.lua
local opt = vim.opt

opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.colorcolumn = ""
opt.scrolloff = 10
opt.termguicolors = true
opt.showmode = false

opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true

opt.winwidth = 100
opt.winminwidth = 30
opt.inccommand = 'nosplit'
opt.viewoptions = { 'cursor', 'folds' }
opt.foldlevel = 99
opt.laststatus = 3

opt.hlsearch = false
opt.hidden = true
opt.cmdheight = 2
opt.updatetime = 200
opt.shortmess:append('cI')
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.signcolumn = 'yes:1'
opt.nrformats = 'bin,hex,alpha'
opt.clipboard = 'unnamedplus'

opt.formatoptions = opt.formatoptions
  - "t" -- Auto-wrap
  + "c" -- Auto-wrap comments
  + "r" -- Auto insert comment when pressing enter.
  - "o" -- Auto insert comment when pressing O and o
  + "q" -- Allow formatting comments w/ gq
  - "a" -- Auto formatting of paragraphs
  + "n" -- When formatting text, recognize numbered lists
  - "2" -- When formatting text, use the indent of the second line of a paragraph 
  + "j" -- Where it makes sense, remove a comment leader when joining lines

require'shxfee.disable_builtin'


------------------------------ MAPPINGS ---------------------------------------
local keymap = vim.keymap

-- Git
keymap.set('n', '<leader>a', ':T ./artisan ')

keymap.set('n', '<leader>wc', '<cmd>wa<bar>only<bar>enew<cr>')
keymap.set('n', '<leader>od', '<cmd>lua require("my.laravel").open_adminer()<cr>')

keymap.set('n', '<leader>se', '<cmd>vsplit $MYVIMRC<cr>')
keymap.set('n', '<leader>so', '<cmd>luafile $MYVIMRC<cr>')

keymap.set('c', '<c-p>', '<up>')
keymap.set('c', '<c-n>', '<down>')


keymap.set('n', '<leader>te', '<cmd>tabe<cr>')

-- keymap.set('n', '<c-l>', '<cmd><C-u>nohlsearch<cr>')
keymap.set('i', '<c-l>', '<esc><cmd><C-u>nohlsearch<cr>a')
keymap.set('c', 'w!!', 'w :term sudo tee > /dev/null %', {silent = false})
keymap.set('t', '<c-o>', '<c-\\><c-n>')

keymap.set('v', '<a-y>', '"+y')
keymap.set('n', '<a-p>', '"+p')
keymap.set('v', '<a-p>', '"+p')
keymap.set('i', '<a-p>', '<c-r>+')

keymap.set('n', 'gV', '`[v`]')

-- vsnip
local cmd = vim.cmd
cmd[[imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']]
cmd[[smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']]
cmd[[imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>']]
cmd[[smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>']]

-- Figure this shit out later
-- Include (count)k/j in jump list
vim.api.nvim_exec([[
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
    ]], false)


-- Commands
vim.api.nvim_exec([[ command! -nargs=* -complete=file T split | startinsert | terminal <args> ]], false)

------------------------------ COMMANDS ---------------------------------------
-- Better API for commands and auto commands is being worked on.
-- ref: https://github.com/neovim/neovim/pull/11613
-- ref: https://github.com/neovim/neovim/pull/12378
cmd [[cabbrev DD DB describe]]
cmd [[cabbrev PI PackerInstall]]
cmd [[cabbrev PU PackerUpdate]]
cmd [[cabbrev PC PackerClean]]
cmd [[cabbrev h vertical help]]
cmd [[iabbrev <expr> dts strftime("%c (MVT)")]]
cmd [[iabbrev <expr> ds strftime("%Y-%m-%d")]]

local function augroup(name, definitions)
    cmd('augroup '..name..' | autocmd!')
    vim.tbl_map(function(c) cmd('autocmd '..c) end, definitions)
    cmd'augroup END'
end

augroup('my_commands', {
    -- General
    'TermOpen * setlocal nowrap',
    -- 'BufWritePost init.lua nested luafile $MYVIMRC',
    -- 'VimEnter * silent! lua require("my.laravel").set_db_connection_string()',
    'TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 300}',
    'BufWritePre * call mkdir(expand("<afile>:p:h"), "p")',
    -- Restore cursor
    [[ BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |   exe "normal! g`\"" | endif ]],
    -- Dirvish
    'FileType dirvish nnoremap <buffer> % :edit %',
    'FileType dirvish nnoremap <nowait> <buffer> d :!mkdir %',
    -- Neorg
    'FileType norg setlocal spell textwidth=79 formatoptions+=t',
    'BufEnter *.blade.php setlocal ft=html',
})
