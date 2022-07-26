-- neovim config
-- github.com/shxfee

local api, cmd, fn, g, opt, keymap = vim.api, vim.cmd, vim.fn, vim.g, vim.opt, vim.keymap

local config_path = fn.stdpath('config')
local plugin_path = fn.stdpath('data') .. '/site/pack/packer/'


------------------------------ OPTIONS ----------------------------------------

opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.colorcolumn = ""
opt.scrolloff = 10
opt.termguicolors = true
opt.showmode = false

opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true

opt.winwidth = 100
opt.winminwidth = 30
opt.inccommand = 'nosplit'
opt.viewoptions = { 'cursor', 'folds' }
opt.foldlevel = 99
opt.laststatus = 3

opt.hlsearch = false
opt.hidden = true
opt.cmdheight = 2
opt.updatetime = 200
opt.shortmess:append('cI')
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.signcolumn = 'yes:1'
opt.nrformats = 'bin,hex,alpha'
opt.clipboard = 'unnamedplus'

------------------------------ PLUGINS ----------------------------------------
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

cmd [[ packadd packer.nvim ]]
local use = require('packer').use
require('packer').startup({function()
    -- dependencies
    use {'wbthomason/packer.nvim', opt = true}
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'

    -- finder
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-neorg/neorg-telescope'

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'windwp/nvim-ts-autotag'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- language server
    use 'onsails/lspkind.nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/nvim-cmp'

    -- ide
    use 'tpope/vim-fugitive'
    use 'justinmk/vim-dirvish'
    use 'janko-m/vim-test'
    use 'hrsh7th/vim-vsnip'
    use 'wakatime/vim-wakatime'
    use 'tpope/vim-dadbod'
    use 'nvim-neorg/neorg'
    use 'kdheepak/lazygit.nvim'
    use 'zbirenbaum/copilot.lua'
    use 'zbirenbaum/copilot-cmp'

    -- text edit
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-abolish'
    use 'godlygeek/tabular'
    use 'justinmk/vim-sneak'

    -- syntax and colors
    use 'shxfee/nord-vim'
    use 'shxfee/oceanic-next-vim'
    use 'kyazdani42/blue-moon'
    use 'Th3Whit3Wolf/one-nvim'
    use 'kyazdani42/nvim-web-devicons'

    use 'xiyaowong/nvim-transparent'
    use 'norcalli/nvim-colorizer.lua'
    use 'StanAngeloff/php.vim'
    use 'posva/vim-vue'

    use 'anuvyklack/pretty-fold.nvim'
    use 'folke/lua-dev.nvim'
    use 'nvim-lualine/lualine.nvim'
end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'rounded' })
            end
        }
    }
})

-- reload my modules
require('plenary.reload').reload_module('my', true)


------------------------------ PLUGIN CONFIG ----------------------------------
g['transparent_enabled '] = 1

g['test#strategy'] = 'neovim'
g['test#neovim#term_position'] = 'split'
g['test#php#phpunit#executable'] = './vendor/bin/phpunit'

g['dirvish_mode'] = [[:sort ,^.*[\/],]]

g['vsnip_snippet_dir'] = config_path .. '/vsnip'
g['vue_pre_processors'] = {}

-- web icons
require'nvim-web-devicons'.setup{}
require'colorizer'.setup{}
require'copilot'.setup{}
require'pretty-fold'.setup{}

-- Make neovim trasparent
require'transparent'.setup{
    enable = true;
    extra_groups = {
        'WinSeparator',
        'TabLine',
        'TabLineFill',
        'VertSplit',
        'Pmenu',
        'PmenuSel',
    };
}

-- telescope
require('telescope').load_extension('fzy_native')
local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        mappings = {
            i = { ['<c-q>'] = actions.send_to_qflist }
        },
    },
}

-- treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash', 'css', 'html', 'javascript', 'json', 'jsonc', 'lua', 'php', 'python',
        'query', 'typescript', 'vue', 'norg', 'yaml',
    },
    indent = { enable = true, disable = { 'html', 'vue' } },
    highlight = { enable = true, disable = { 'vue' } },
    context_commentstring = { enable = true },
    autotag = {
        enable = true,
        filetypes = { 'php', 'html', 'vue' },
    },
}

-- lsp configuration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
    'bashls', 'cssls', 'diagnosticls', 'html', 'jsonls',
    'intelephense', 'tailwindcss', 'vuels',
}

-- setup all servers
local lspconfig = require('lspconfig')

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

local luadev = require("lua-dev").setup{}
lspconfig.sumneko_lua.setup(luadev)

require("mason").setup {
    ui = { border = 'rounded', }
}
require("mason-lspconfig").setup {
    ensure_installed = servers,
}

-- Setup nvim-cmp
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
        format = require'lspkind'.cmp_format(),
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
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'neorg' },
    }, {
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
        { name = 'path' },
        { name = "copilot" },
    })
})

-- autopairs
require('nvim-autopairs').setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = false,
    }
)

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
                workspace = "documents",
                strategy = "flat",
            },
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    documents = "~/documents",
                    notes = "~/documents/notes",
                    gtd = "~/documents/gtd",
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

-- Bind neorg telescope keys
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

-- personal plugs
dofile(config_path .. '/lua/my/statusline.lua')         -- status & tabline
dofile(config_path .. '/lua/my/playground.lua')         -- temporary stuff


------------------------------ MAPPINGS ---------------------------------------
g['mapleader'] = " "

-- telescope
keymap.set('n', '<leader>ff', function ()
    return require('telescope.builtin').find_files{previewer=false}
end)

keymap.set('n', '<leader>fd', function ()
    return require('telescope.builtin').find_files{
        find_command = {"fd", "--type", "d"},
        previewer=false
    }
end)

keymap.set('n', '<leader>fg', function ()
    return require('telescope.builtin').live_grep{}
end)

keymap.set('n', '<leader>fc', function ()
    return require('telescope.builtin').colorscheme{}
end)

keymap.set('n', '<leader>fb', function ()
    return require('telescope.builtin').current_buffer_fuzzy_find{}
end)

keymap.set('n', '<leader>fh', function ()
    return require('telescope.builtin').help_tags{}
end)

keymap.set('n', '<leader>fe', function ()
    return require('telescope.builtin').find_files{
        cwd=config_path,
        previewer=false,
    }
end)

keymap.set('n', '<leader>fp', function ()
    return require('telescope.builtin').find_files{
        find_command = {"fd", "--type", "d"},
        cwd=plugin_path,
        previewer=false,
    }
end)

-- Git
keymap.set('n', '<leader>gg', ':vertical Git<cr>')
keymap.set('n', '<leader>gl', '<cmd>LazyGit<cr>')
keymap.set('n', '<leader>gb', ':0GlLog!<cr>')


-- Journal
keymap.set('n', '<leader>nn', '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg workspace notes"<cr>')
keymap.set('n', '<leader>nt', '<cmd>e ~/documents/gtd/inbox.norg<cr>')
keymap.set('n', '<leader>jj', '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal today"<cr>')
keymap.set('n', '<leader>jt', '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal tomorrow"<cr>')
keymap.set('n', '<leader>jy', '<cmd>exe "silent! NeorgStart" | exe "silent! Neorg journal yesterday"<cr>')
keymap.set('n', '<leader>ji', '<cmd>e ~/documents/journal/index.norg<cr>')


-- Other
keymap.set('n', '<leader>1', ':Cheat php/')


keymap.set('n', '<leader>wc', '<cmd>wa<bar>only<bar>enew<cr>')
keymap.set('n', '<leader>od', '<cmd>lua require("my.laravel").open_adminer()<cr>')

keymap.set('n', '<leader>se', '<cmd>vsplit $MYVIMRC<cr>')
keymap.set('n', '<leader>so', '<cmd>luafile $MYVIMRC<cr>')

keymap.set('c', '<c-p>', '<up>')
keymap.set('c', '<c-n>', '<down>')

keymap.set('n', '<leader>tt', '<cmd>lua require("my.utils").run_nearest_or_last_test()<cr>')
keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>')
keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>')
keymap.set('n', '<leader>ts', '<cmd>TestSuite<cr>')

keymap.set('n', '<leader>te', '<cmd>tabe<cr>')

keymap.set('n', '<c-l>', '<cmd><C-u>nohlsearch<cr>')
keymap.set('i', '<c-l>', '<esc><cmd><C-u>nohlsearch<cr>a')
keymap.set('c', 'w!!', 'w :term sudo tee > /dev/null %', {silent = false})
keymap.set('t', '<c-o>', '<c-\\><c-n>')

keymap.set('v', '<a-y>', '"+y')
keymap.set('n', '<a-p>', '"+p')
keymap.set('v', '<a-p>', '"+p')
keymap.set('i', '<a-p>', '<c-r>+')

keymap.set('n', 'gV', '`[v`]')

-- lsp
keymap.set('n', 'gD', vim.lsp.buf.declaration)
keymap.set('n', 'gd', vim.lsp.buf.definition)
keymap.set('n', 'K', vim.lsp.buf.hover)
keymap.set('n', 'gi', vim.lsp.buf.implementation)
keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
keymap.set('n', '<space>rn', vim.lsp.buf.rename)
keymap.set('n', '<space>ca', vim.lsp.buf.code_action)
keymap.set('n', 'gr', vim.lsp.buf.references)
keymap.set('n', '<space>e', vim.diagnostic.open_float)
keymap.set('n', '[d', vim.diagnostic.goto_prev)
keymap.set('n', ']d', vim.diagnostic.goto_next)
keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- vsnip
cmd[[imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']]
cmd[[smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']]
cmd[[imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>']]
cmd[[smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>']]

-- Figure this shit out later
-- Include (count)k/j in jump list
api.nvim_exec([[
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
    ]], false)


-- Commands
api.nvim_exec([[ command! -nargs=* -complete=file T split | startinsert | terminal <args> ]], false)

------------------------------ COMMANDS ---------------------------------------
-- Better API for commands and auto commands is being worked on.
-- ref: https://github.com/neovim/neovim/pull/11613
-- ref: https://github.com/neovim/neovim/pull/12378
cmd [[cabbrev DD DB describe]]
cmd [[cabbrev PI PackerInstall]]
cmd [[cabbrev PU PackerUpdate]]
cmd [[cabbrev PC PackerClean]]
cmd [[cabbrev h vertical help]]
cmd [[iabbrev <expr> dts strftime("%c (MVT)")]]
cmd [[iabbrev <expr> ds strftime("%Y-%m-%d")]]

local function augroup(name, definitions)
    cmd('augroup '..name..' | autocmd!')
    vim.tbl_map(function(c) cmd('autocmd '..c) end, definitions)
    cmd'augroup END'
end

augroup('my_commands', {
    -- General
    'TermOpen * setlocal nowrap',
    'BufWritePost init.lua nested luafile $MYVIMRC',
    'BufWritePost init.lua PackerCompile',
    'VimEnter * silent! lua require("my.laravel").set_db_connection_string()',
    'TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 300}',
    'BufWritePre * call mkdir(expand("<afile>:p:h"), "p")',
    -- Restore cursor
    [[ BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |   exe "normal! g`\"" | endif ]],
    -- Dirvish
    'FileType dirvish nnoremap <buffer> % :edit %',
    'FileType dirvish nnoremap <nowait> <buffer> d :!mkdir %',
    -- Neorg
    'FileType norg setlocal spell textwidth=79 formatoptions+=t',
})

cmd [[ colorscheme nord ]]
