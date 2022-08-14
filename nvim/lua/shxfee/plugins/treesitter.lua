if not pcall(require, "nvim-treesitter") then
    return
end

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash', 'css', 'html', 'javascript', 'json', 'jsonc', 'lua', 'php', 'python',
        'query', 'typescript', 'vue', 'norg', 'yaml',
    },
    indent = { enable = true, disable = { 'html', 'vue' } },
    highlight = { enable = true, disable = { 'vue' } },
    context_commentstring = { enable = true },
    autotag = {
        enable = true,
        filetypes = { 'php', 'html', 'vue' },
    },
}
