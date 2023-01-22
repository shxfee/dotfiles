-- :T to Open terminal
vim.api.nvim_create_user_command(
    "T",
    function (opts)
        vim.cmd("split | startinsert | terminal " .. table.concat(opts.fargs, ' '))
    end,
    { nargs = "*", complete = "file" }
)
