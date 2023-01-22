local keymap = vim.keymap

-- Git
keymap.set('n', '<leader>a', ':T ./vendor/bin/sail artisan')

keymap.set('n', '<leader>wc', '<cmd>wa<bar>only<bar>enew<cr>')
keymap.set('n', '<leader>od', '<cmd>lua require("my.laravel").open_adminer()<cr>')

keymap.set('n', '<leader>se', '<cmd>vsplit $MYVIMRC<cr>')
keymap.set('n', '<leader>so', '<cmd>luafile $MYVIMRC<cr>')

keymap.set('c', '<c-p>', '<up>')
keymap.set('c', '<c-n>', '<down>')


keymap.set('n', '<leader>te', '<cmd>tabe<cr>')

-- keymap.set('n', '<c-l>', '<cmd><C-u>nohlsearch<cr>')
-- keymap.set('i', '<c-l>', '<esc><cmd><C-u>nohlsearch<cr>a')
keymap.set('c', 'w!!', 'w :term sudo tee > /dev/null %', {silent = false})
keymap.set('t', '<c-o>', '<c-\\><c-n>')

keymap.set('v', '<a-y>', '"+y')
keymap.set('n', '<a-p>', '"+p')
keymap.set('v', '<a-p>', '"+p')
keymap.set('i', '<a-p>', '<c-r>+')

keymap.set('n', 'gV', '`[v`]')

-- open links in browser
keymap.set( 'n', 'gl', [[:execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>]], {silent = true})
