return {
    {
        "shxfee/nord-vim",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd([[ colorscheme nord]])
        end
    },

    "shxfee/oceanic-next-vim",
    "kyazdani42/blue-moon",
    "Th3Whit3Wolf/one-nvim",

    {
        "xiyaowong/nvim-transparent",
        opts = {
            enable = true;
            extra_groups = {
                'WinSeparator',
                'VertSplit',
                'TabLine',
                'TabLineFill',
                'Pmenu',
                'PmenuSel',
                'Folded',
            };
        }
    },
}
