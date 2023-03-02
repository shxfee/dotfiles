local opt = vim.opt

-- ui
opt.number = true
opt.relativenumber = true
opt.colorcolumn = ""
opt.termguicolors = true
opt.showmode = false
opt.showcmd = false
opt.inccommand = "nosplit" -- show live preview of substitutions
opt.laststatus = 3
opt.hlsearch = true
opt.hidden = true -- hide buffers instead of closing
opt.cmdheight = 2
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.conceallevel = 2
opt.concealcursor = "nc"

-- windows
opt.splitbelow = true
opt.scrolloff = 10
opt.winwidth = 110
opt.winminwidth = 30

-- text
opt.wrap = false
opt.breakindent = true
opt.autoindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 300
opt.timeout = true
opt.timeoutlen = 500
opt.shortmess:append("cI")
opt.completeopt = { "menu", "menuone", "noselect" }
opt.signcolumn = "yes:1"
opt.nrformats = "bin,hex,alpha"
opt.clipboard = ""
opt.undofile = true

opt.viewoptions = { "cursor", "folds" }
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
