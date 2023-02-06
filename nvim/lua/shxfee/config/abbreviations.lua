------------------------------ COMMANDS ---------------------------------------
-- Better API for commands and auto commands is being worked on.
-- ref: https://github.com/neovim/neovim/pull/11613
-- ref: https://github.com/neovim/neovim/pull/12378

local cmd = vim.cmd

cmd [[cabbrev DD DB describe]]
cmd [[cabbrev PI PackerInstall]]
cmd [[cabbrev PU PackerUpdate]]
cmd [[cabbrev PC PackerClean]]
cmd [[cabbrev h vertical help]]
cmd [[cabbrev sail ./vendor/bin/sail]]
cmd [[iabbrev <expr> dts strftime("%c (MVT)")]]
cmd [[iabbrev <expr> ds strftime("%Y-%m-%d")]]

cmd [[cabbrev w!! w :term sudo tee > /dev/null %]]
