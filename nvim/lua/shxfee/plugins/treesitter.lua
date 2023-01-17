if not pcall(require, "nvim-treesitter") then
    return
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'bash', 'css', 'html', 'javascript', 'json', 'jsonc', 'lua', 'php', 'python',
        'query', 'typescript', 'vue', 'norg', 'yaml',
    },

    auto_install = true,

    indent = {
        enable = true,
        -- disable = {'php'},
    },

    highlight = {
        enable = true,
        -- disable = {'php'},
        additional_vim_regex_highlighting = false,
    },

    context_commentstring = {
        enable = true,
    },

    autotag = {
        enable = true,
        filetypes = { 'php', 'html', 'vue' },
    },
}
