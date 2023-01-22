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
  - "r" -- Auto insert comment when pressing enter.
  - "o" -- Auto insert comment when pressing O and o
  + "q" -- Allow formatting comments w/ gq
  - "a" -- Auto formatting of paragraphs
  + "n" -- When formatting text, recognize numbered lists
  - "2" -- When formatting text, use the indent of the second line of a paragraph 
  + "j" -- Where it makes sense, remove a comment leader when joining lines
