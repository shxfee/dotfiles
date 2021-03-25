local vim = vim

-- Remove cached my.modules so they will be sourced again
-- otherwise I will need to restart vim everytime after updating
-- any lua modules
for k, v in pairs(package.loaded) do
    if vim.startswith(k, 'my') then
        package.loaded[k] = nil
    end
end


-- I cant really rely on the build in LSP as of yet. The main block is tailwind
-- language server. They don't have a separate build for the LSP yet. There is
-- a way to get it working using the VS code extension. However I think its not
-- worth it yet. They are actually working on extracting a separate LSP. I ll
-- hopefully get to switch once that is completed.
--
-- require('my.lsp')


-- There is no reason why I can't build my own statusline. I have to read the
-- help pages and figure this out. Lightline is very light though. So there
-- might not be a need to do this. I ll tinker with it more in the future
-- though.
--
-- require('my.statusline')


-- I tried replacing FZF with telescope. However it turned out telescope is 
-- pretty slow. They are having a hard time making it faster and so might take
-- a while before I am able to change my setup. so leaving this here for now
--
-- require('my.telescope')
