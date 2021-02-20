-- Wrapper to execute tests via vim-test 
-- If we are in a test file, execute the nearest test to the cursor
-- Otherwise execute the last test
function runNearestOrLastTest()
    filename = vim.fn.expand('%')

    if filename:match('Test.*') then
        vim.cmd [[ TestNearest ]]
    else
        vim.cmd [[ TestLast ]]
    end
end


-- Generate a filename from project root for Lightline
-- If current file is a git repo then start path from git root
-- Otherwise show full filename
function getGitFilename()
    root = vim.fn.fnamemodify(vim.b.git_dir, ':h') -- git folder path
    path = vim.fn.expand('%:p')

    if vim.startswith(path, root) then
        return path:sub(root:len() + 1, nil)
    end
    return vim.fn.expand('%')
end


-- Show documentation
-- If filetype is vim or help search vim help
-- Otherwise execute CocAction
function openDocumentation()
    if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
        vim.cmd('help ' .. vim.fn.expand('<cexpr>'))
    else
        vim.cmd [[ call CocAction('doHover') ]]
    end
end
