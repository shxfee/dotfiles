------------------------------ PLUGINS ----------------------------------------
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[ packadd packer.nvim ]]
local use = require('packer').use
require('packer').startup({function()
    -- dependencies
    use {'wbthomason/packer.nvim', opt = true}
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'windwp/nvim-ts-autotag'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- language server
    use 'onsails/lspkind.nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- finder
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-neorg/neorg-telescope'

    -- completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/nvim-cmp'

    -- ide
    use 'tpope/vim-fugitive'
    use 'justinmk/vim-dirvish'
    use 'janko-m/vim-test'
    use 'hrsh7th/vim-vsnip'
    use 'wakatime/vim-wakatime'
    use 'tpope/vim-dadbod'
    use 'nvim-neorg/neorg'
    use 'kdheepak/lazygit.nvim'
    use 'github/copilot.vim'
    use 'ThePrimeagen/refactoring.nvim'

    -- text edit
    use {
        'windwp/nvim-autopairs',
        config = function() require'nvim-autopairs'.setup() end
    }
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-abolish'
    use 'godlygeek/tabular'
    use 'justinmk/vim-sneak'

    -- syntax and colors
    use 'shxfee/nord-vim'
    use 'shxfee/oceanic-next-vim'
    use 'kyazdani42/blue-moon'
    use 'Th3Whit3Wolf/one-nvim'
    use {
        'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-web-devicons'.setup{} end
    }

    use 'xiyaowong/nvim-transparent'
    use {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup {
                filetypes = {
                    '*';
                    '!neorg';
                }
            }
        end
    }

    use {
        'anuvyklack/pretty-fold.nvim',
        config = function() require'pretty-fold'.setup{} end
    }

    use 'folke/neodev.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'arkav/lualine-lsp-progress'
    use 'kkharji/lspsaga.nvim'
end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'rounded' })
            end
        }
    }
})

-- Plugin configurations
require'shxfee.plugins.cmp'
require'shxfee.plugins.lsp_config'
require'shxfee.plugins.lualine'
require'shxfee.plugins.neorg'
require'shxfee.plugins.telescope'
require'shxfee.plugins.test'
require'shxfee.plugins.transparent'
require'shxfee.plugins.treesitter'
