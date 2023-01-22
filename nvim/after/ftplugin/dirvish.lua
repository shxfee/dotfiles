-- for the file manager, dirvish
vim.keymap.set('n', '%', ':edit %', {buffer = true, nowait = true})
vim.keymap.set('n', 'd', ':!mkdir %', {buffer = true, nowait = true})
vim.keymap.set('n', 'm', ':!mv % %', {buffer = true, nowait = true})
