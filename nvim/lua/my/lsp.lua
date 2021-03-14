local vim = vim
local lspconfig = require('lspconfig')
local completion = require('completion')

-- Completion configuration
vim.g.completion_confirm_key = "<C-y>"
vim.g.completion_enable_auto_hover = 0
vim.g.completion_enable_auto_signature = 0
vim.g.completion_sorting = "length"
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
vim.g.completion_matching_smart_case = 1
vim.g.completion_trigger_keyword_length = 1


-- PHP
lspconfig.intelephense.setup{
    on_attach=completion.on_attach
}
