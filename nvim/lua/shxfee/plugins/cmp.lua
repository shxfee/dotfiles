if not pcall(require, "cmp") then
    return
end

local cmp = require'cmp'

cmp.setup({
    window = {
        completion = {
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:Normal,CursorLine:PmenuSel,Search:None',
        },
        documentation = { border = 'rounded', }
    },
    formatting = {
        format = require'lspkind'.cmp_format{
            with_text = true,
            menu = {
                nvim_lsp = '[lsp]',
                vsnip = '[snip]',
                neorg = '[norg]',
                buffer = '[buf]',
                path = '[path]',
            },

        },
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'path', group_index = 1, priority = 1 },
        { name = 'neorg', group_index = 1, priority = 1 },
        { name = 'vsnip', group_index = 2, priority = 1 },
        { name = 'nvim_lsp', group_index = 2, priority = 0.5 },
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            },
            group_index = 2,
            priority = 0.5,
        },
    },

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    -- Just trying out
    experimental = {
        native_menu = false,
        ghost_text = false,
    },
})
