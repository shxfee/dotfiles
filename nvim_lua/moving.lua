-- Plugins
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}

    -- IDE
    use 'tpope/vim-dispatch'
    use 'tpope/vim-fugitive'
    use {'junegunn/fzf', run = 'cd ~/.local/share/.fzf && ./install --all'}
    use 'junegunn/fzf.vim'
    use 'SirVer/ultisnips'
    use 'justinmk/vim-dirvish'
    use {'vimwiki/vimwiki', branch = 'dev'}
    use 'janko-m/vim-test'
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-projectionist'
    use 'kkoomen/vim-doge'
    use 'wakatime/vim-wakatime'
    use 'tpope/vim-dadbod'
    use {'neoclide/coc.nvim', branch = 'release'}

    -- Vimfu
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'godlygeek/tabular'
    use 'tpope/vim-abolish'
    use 'justinmk/vim-sneak'

    -- Syntax & UI
    use 'sheerun/vim-polyglot'
    use 'itchyny/lightline.vim'
    use 'nanotech/jellybeans.vim'
    use 'lifepillar/vim-solarized8'
end)


-- Plugin Configuration
vim.g['fzf_layout'] = { down = '~25%' }
vim.g['sneak#use_ic_scs'] = 1
vim.g['doge_mapping'] = ''
vim.g['UltiSnipsEditSplit'] = 'vertical'

vim.g['vimwiki_hl_headers'] = 1
vim.g['vimwiki_conceal_onechar_markers'] = 0
vim.g['vimwiki_folding'] = 'list:quick'

vim.g['AutoPairsShortcutToggle'] = ''
vim.g['AutoPairsMultilineClose'] = 0

vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = "belowright 15"
vim.g['test#php#phpunit#executable'] = './vendor/bin/phpunit'

vim.g['dirvish_mode'] = ":sort ,^.*[\\/],"
vim.g['loaded_netrw'] = 1 -- disable netrw
vim.g['loaded_netrwPlugin'] = 1

vim.g['lightline'] = {
    colorscheme = 'google',
    active = {
        left = { 'paste',  'git', 'modified' },
        right = { 'percent', 'line' },
    },
    inactive = {
        left = {},
    },
    component_function = {
        git = 'fugitive#head',
    }
}

-- Editor Configuration
vim.o.termguicolors = true
vim.cmd 'colorscheme google'

vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.showmode = false
vim.o.scrolloff = 3

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.winminwidth = 10
vim.o.winwidth = 100

vim.o.inccommand='nosplit'
vim.o.viewoptions='cursor,folds'
vim.o.foldmethod='indent'
vim.o.foldminlines=0
vim.o.foldlevelstart=99
vim.o.swapfile = false
vim.o.spellfile = '~/.local/share/nvim/spell/en.utf-8.add'
vim.o.hidden = true
vim.o.cmdheight = 2
vim.o.updatetime = 50
vim.o.shortmess = vim.o.shortmess .. 'cI'
vim.o.signcolumn = 'yes'
vim.o.nrformats = 'bin,hex,alpha'


-- Key Bindings
vim.g.mapleader = ' '

-- Abbreviations
vim.cmd [[ cabbrev DD DB describe ]]
vim.cmd [[ cabbrev DS DB show tables ]]
vim.cmd [[ cabbrev h vertical help ]]
vim.cmd [[ cabbrev PI PlugInstall ]]
vim.cmd [[ cabbrev PC PlugClean ]]
vim.cmd [[ cabbrev CE vsplit ~/dotfiles/nvim/colors/google.vim ]]
vim.cmd [[ iabbrev <expr> dts strftime("%c (MVT)") ]]
vim.cmd [[ iabbrev <expr> ds strftime("%Y-%m-%d") ]]
