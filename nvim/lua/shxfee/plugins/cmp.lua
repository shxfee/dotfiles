return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "onsails/lspkind.nvim",
    },

    opts = function()
      local cmp = require("cmp")
      return {
        window = {
          completion = {
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:Normal,CursorLine:PmenuSel,Search:None',
          },
          documentation = { border = 'rounded', }
        },

        completion = {
          -- noselect, noinsert are for more consistent behavior
          completeopt = "menu,menuone,noselect,noinsert",
          keyword_length = 4,
        },

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = {
          ["<C-p>"] = cmp.mapping(function ()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
              cmp.select_prev_item()
            end
          end, {"i", "s"}),

          ["<C-n>"] = cmp.mapping(function ()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
              cmp.select_next_item()
            end
          end, {"i", "s"}),

          ["<C-b>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.scroll_docs(-4)
            else
              fallback()
            end
          end, {"i", "s"}),

          ["<C-f>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.scroll_docs(4)
            else
              fallback()
            end
          end, {"i", "s"}),

          ["<C-e>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.abort()
              cmp.close()
            else
              fallback()
            end
          end, {"i", "s", "c"}),

          ["<C-y>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.confirm()
            else
              fallback()
            end
          end, {"i", "s", "c"}),

          ["<Tab>"] = cmp.mapping(function ()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
              cmp.select_next_item()
            end
          end, {"c"}),

          ["<S-Tab>"] = cmp.mapping(function ()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
              cmp.select_prev_item()
            end
          end, {"c"}),
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "neorg" },
        }),

        formatting = {
          format = require'lspkind'.cmp_format{
            with_text = true,
            maxwidth = 50,
            ellipsis_char = '…',
            -- menu = {
            --   menu
            --   nvim_lsp = 'lsp',
            --   vsnip = 'snip',
            --   neorg = 'norg',
            --   buffer = 'buf',
            --   path = 'path',
            -- },
          },
        },

        experimental = {
          ghost_text = false,
        },
      }
    end,

    config = function (plugin, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      cmp.setup.cmdline(':', {
        completion = {
          autocomplete = false,
          keyword_length = 1,
        },
        sources = cmp.config.sources(
          {
            { name = 'path', max_item_count = 5 },
          },
          {
            { name = 'cmdline', max_item_count = 5 },
          }
        ),
      })
    end,
  },
}
