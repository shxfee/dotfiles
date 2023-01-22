return {
    -- keeping track of time
    {
        "wakatime/vim-wakatime",
    },

    -- copilot
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
}
