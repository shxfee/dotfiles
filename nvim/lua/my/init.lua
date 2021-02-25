local vim = vim

-- Remove cached my.modules so they will be sourced again
-- otherwise I will need to restart vim everytime after updating
-- any lua modules
for k, v in pairs(package.loaded) do
    if vim.startswith(k, 'my') then
        package.loaded[k] = nil
    end
end


require('my.lsp')
require('my.statusline')
