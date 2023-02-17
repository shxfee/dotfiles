return {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_event = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
    },

    keys = {
      { "<C-p>", mode = "i" },
      { "<C-n>", mode = "i" },
      { "<C-b>", mode = "i" },
      { "<C-f>", mode = "i" },
      { "<C-e>", mode = "i" },
      { "<C-y>", mode = "i" },
      { "<Tab>", mode = "c" },
      { "<S-Tab>", mode = "c" },
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
          completeopt = "menu,menuone,noinsert,noselect",
          keyword_length = 2,
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
            end
          end, {"i", "s"}),

          ["<C-n>"] = cmp.mapping(function ()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
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
              cmp.confirm({ select = true })
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
          completeopt = "menu,menuone,noinsert,noselect",
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
