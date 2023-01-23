local keymap = vim.keymap

-- artisan
keymap.set('n', '<leader>aa', ':T ./vendor/bin/sail artisan', {desc='artisan cmd'})

-- window
keymap.set('n', '<leader>wc', '<cmd>wa<bar>only<bar>enew<cr>', {desc="clear all windows"})

-- git
keymap.set("n", "<leader>gp", ":Git push<CR>", {desc="git push"})

-- config
keymap.set('n', '<leader>ce', '<cmd>vsplit $MYVIMRC<cr>', {desc="edit init.lua"})
keymap.set('n', '<leader>cl', '<cmd>Lazy<cr>', {desc="lazy plugin manager"})

keymap.set('c', '<c-p>', '<up>')
keymap.set('c', '<c-n>', '<down>')

-- tabs
keymap.set('n', '<leader><tab><tab>', '<cmd>tabe<cr>', {desc="new tab"})

keymap.set('c', 'w!!', 'w :term sudo tee > /dev/null %', {silent = false})
keymap.set('t', '<c-o>', '<c-\\><c-n>')

keymap.set('v', '<a-y>', '"+y')
keymap.set('n', '<a-p>', '"+p')
keymap.set('v', '<a-p>', '"+p')
keymap.set('i', '<a-p>', '<c-r>+')

keymap.set('n', 'gV', '`[v`]')

-- open links in browser
keymap.set( 'n', 'gl', [[:execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>]], {silent = true})
