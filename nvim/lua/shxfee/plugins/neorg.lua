return {
  {
    "nvim-neorg/neorg",
    version = false,
    build = ":Neorg sync-parsers",
    ft = "norg",
    cmd = "Neorg",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
      "nvim-cmp",
    },
    keys = {
      {
        "<leader>nN",
        "<cmd>e ~/documents/notes/index.norg<cr>",
        desc = "notes index",
      },
      {
        "<leader>nn",
        "<cmd>e notes.norg<cr>",
        desc = "current project notes",
      },
      {
        "<leader>jj",
        '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal today"<cr>',
        desc = "todays entry",
      },
      {
        "<leader>jt",
        '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal tomorrow"<cr>',
        desc = "tomorrows entry",
      },
      {
        "<leader>jy",
        '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal yesterday"<cr>',
        desc = "yesterdays entry",
      },
      {
        "<leader>ji",
        "<cmd>e ~/documents/journal/index.norg<cr>",
        desc = "journal index",
      },
      {
        "<leader>jr",
        "<cmd>Neorg journal toc update<cr>",
        desc = "refresh journal toc",
      },
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.norg.completion"] = {
          config = {
            engine = "nvim-cmp"
          }
        },
        ["core.norg.journal"] = {
          config = {
            use_template = true,
            workspace = "documents",
            strategy = "flat",
            tocc_format = function(toc)
              local titles = {}
              for k, v in pairs(toc) do
                table.insert(titles, "foobar")
              end
              return titles
            end,
          },
        },
        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              notes = "~/documents/notes",
              documents = "~/documents",
            },
            default_workspace = "notes",
            autochdir = false,
          },
        },
        ["core.norg.concealer"] = {
          config = {
            folds = false,
            preset = "diamond", -- basic, varied or diamond
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
          },
        },
        ["core.export"] = {},
      },
    },
  },
}
