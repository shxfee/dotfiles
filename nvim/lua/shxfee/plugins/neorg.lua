if not pcall(require, 'neorg') then return end

-- norg
require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.norg.journal"] = {
            config = {
                use_template = true,
                workspace = "documents",
                strategy = "flat",
                tocc_format = function (toc)
                    local titles = {}
                    -- vim.pretty_print(toc)
                    for k, v in pairs(toc) do
                        table.insert(titles, 'foobar')
                    end
                    return titles
                end
            },
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/documents/notes",
                    gtd = "~/documents/gtd",
                    documents = "~/documents",
                },
                default_workspace = "notes",
                autochdir = false,
            },
        },
        ["core.norg.concealer"] = {
            config = {
                preset = "diamond", -- basic, varied or diamond
            },
        },
        ["core.gtd.base"] = {
            config = {
                workspace = "gtd",
                custom_tag_completion = true,
            },
        },
        ["core.integrations.telescope"] = {
            config = {
                -- empty
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = false,
                hook = function(keybinds)
                    keybinds.remap_event("norg", "n", "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle")
                    keybinds.remap_event("norg", "n", "<CR>", "core.norg.esupports.hop.hop-link")
                end,
            }
        },
        ["core.export"] = {},
    },
}


local neorg_callbacks = require("neorg.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
            { "<SPACE>ns", "core.integrations.telescope.find_linkable" },
        },

        i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
        },
    }, {
        silent = true,
        noremap = true,
    })
end)

local keymap = vim.keymap

keymap.set('n', '<leader>nn', '<cmd>e ~/documents/notes/index.norg<cr>')
keymap.set('n', '<leader>nt', '<cmd>e ~/documents/gtd/inbox.norg<cr>')
keymap.set('n', '<leader>jj', '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal today"<cr>')
keymap.set('n', '<leader>jt', '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal tomorrow"<cr>')
keymap.set('n', '<leader>jy', '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal yesterday"<cr>')
keymap.set('n', '<leader>ji', '<cmd>e ~/documents/journal/index.norg<cr>')
keymap.set('n', '<leader>jr', '<cmd>Neorg journal toc update<cr>')
