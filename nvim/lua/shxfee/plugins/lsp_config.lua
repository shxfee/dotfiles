-- keymaps
local keymap = vim.keymap

keymap.set('n', 'gD', vim.lsp.buf.declaration)
keymap.set('n', 'gd', vim.lsp.buf.definition)
keymap.set('n', 'K', vim.lsp.buf.hover)
keymap.set('n', 'gi', vim.lsp.buf.implementation)
keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
keymap.set('n', 'gr', vim.lsp.buf.rename)
keymap.set('n', 'gx', vim.lsp.buf.code_action)
keymap.set('n', ']d', vim.diagnostic.goto_next)
keymap.set('n', '[d', vim.diagnostic.goto_prev)

-- diagnostics configuration
vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        header = false,
        source = 'if_many',
        border = 'rounded',
        focusable = false,
    },
    update_in_insert = false, -- default to false
    severity_sort = false, -- default to false
})

-- hover float window configuration
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded"
    }
)

-- signature help float window configuration
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "single"
    }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = false,
    }
)

-- lsp configuration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
    'bashls', 'cssls', 'diagnosticls', 'html', 'jsonls',
    'intelephense', 'tailwindcss', 'vuels',
}

-- setup all servers
local lspconfig = require('lspconfig')

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

local luadev = require("lua-dev").setup{}
lspconfig.sumneko_lua.setup(luadev)

require("mason").setup {
    ui = { border = 'rounded', }
}

require("mason-lspconfig").setup {
    ensure_installed = servers,
}

