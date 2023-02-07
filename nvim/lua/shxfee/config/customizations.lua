-- Figure this shit out later
-- Include (count)k/j in jump list
vim.api.nvim_exec([[
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
]], false)

-- lsp diagnostics signs
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = ""
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
