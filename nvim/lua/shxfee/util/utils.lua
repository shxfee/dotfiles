local fn, cmd = vim.fn, vim.cmd

local M = {}

-- Wrapper to execute tests via vim-test
-- If we are in a test file, execute the nearest test to the cursor
-- Otherwise execute the last test
function M.run_nearest_or_last_test()
  local filename = fn.expand('%')

  if filename:match('Test.*') or filename:match('test.*') then
    vim.cmd [[ TestNearest ]]
  else
    vim.cmd [[ TestLast ]]
  end
end

-- Show documentation
-- If filetype is vim or help search vim help
-- Otherwise execute CocAction
function M.open_documentation()
  if vim.tbl_contains({'vim', 'help', 'lua'}, vim.bo.filetype) then
    vim.cmd('help ' .. fn.expand('<cexpr>'))
  else
    vim.cmd [[ call CocAction('doHover') ]]
  end
end


-- Print the syntax group of the text under cursor
-- Helper I sometimes use when debugging color schemes
function M.print_syn_group()
  local s = fn.synID(fn.line('.'), fn.col('.'), 1)
  print(fn.synIDattr(s, 'name') .. ' -> ' .. fn.synIDattr(fn.synIDtrans(s), 'name'))
end


-- Compile and run C program
function M.compile_and_run_c()
  local filename = fn.expand('%<')

  cmd'w | sp'
  cmd('term gcc -Wall ' .. fn.shellescape('%') .. ' -o ' .. fn.shellescape('%:r'))

  vim.wait(200, function()
  end)

  cmd('sp')
  cmd('term ./' .. filename)
end

return M
