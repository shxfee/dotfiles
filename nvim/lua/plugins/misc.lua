return {
    -- dependencies
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "tpope/vim-repeat",

    -- ide
    "wakatime/vim-wakatime",
    "tpope/vim-dadbod",
    {
        "github/copilot.vim",
        event = "InsertEnter",
        init = function ()
            vim.g.copilot_filetypes = {
                norg = false,
                TelescopePrompt = false,
            }
        end
    },
    "ThePrimeagen/refactoring.nvim",

    -- syntax and colors
    {
        "kyazdani42/nvim-web-devicons",
    },
    {
        "anuvyklack/pretty-fold.nvim",
        config = function() require'pretty-fold'.setup{} end
    },
}
