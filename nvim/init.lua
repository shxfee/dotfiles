-- neovim config
-- github.com/shxfee

local api, cmd, fn, g, opt, keymap = vim.api, vim.cmd, vim.fn, vim.g, vim.opt, vim.keymap

config_path = fn.stdpath('config')
plugin_path = fn.stdpath('data') .. '/site/pack/packer/'

------------------------------ PLUGINS ----------------------------------------
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

cmd [[ packadd packer.nvim ]]
local use = require('packer').use
require('packer').startup(function()
    -- dependencies
    use {'wbthomason/packer.nvim', opt = true}
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'

    -- finder
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'windwp/nvim-ts-autotag'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- language server
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

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
    use {'vimwiki/vimwiki', branch = 'dev'}
    use 'hrsh7th/vim-vsnip'
    use 'wakatime/vim-wakatime'
    use 'tpope/vim-dadbod'
    use 'nvim-neorg/neorg'
    use 'kdheepak/lazygit.nvim'

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
    use 'norcalli/nvim-colorizer.lua' -- color highlights: need to configure
    use 'StanAngeloff/php.vim'
    use 'posva/vim-vue'
end)

-- reload my modules
require('plenary.reload').reload_module('my', true)


------------------------------ PLUGIN CONFIG ----------------------------------
g['transparent_enabled '] = 1

g['test#strategy'] = 'neovim'
g['test#neovim#term_position'] = 'split'
g['test#php#phpunit#executable'] = './vendor/bin/phpunit'

g['dirvish_mode'] = [[:sort ,^.*[\/],]]

g['vimwiki_hl_headers'] = 1
g['vimwiki_conceal_onechar_markers'] = 0
g['vimwiki_global_ext'] = 0

g['vsnip_snippet_dir'] = config_path .. '/vsnip'
g['vue_pre_processors'] = {}

-- web icons
require'nvim-web-devicons'.setup{}

-- Make neovim trasparent
require'transparent'.setup{
    enable = true;
    extra_groups = 'all';
    exclude = {
       "Visual",
    }
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
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash', 'css', 'html', 'javascript', 'json', 'jsonc', 'lua', 'php', 'python',
        'query', 'typescript', 'vue', 'norg', 'norg_meta', 'norg_table'
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_installer_servers = require'nvim-lsp-installer.servers'

local servers = {
    'bashls', 'cssls', 'diagnosticls', 'html', 'jsonls', 'sumneko_lua', 
    'intelephense', 'tailwindcss', 'vuels',
}

-- setup server or install if missing
for _, server in pairs(servers) do
    local server_available, requested_server = lsp_installer_servers.get_server(server)

    if server_available then
        requested_server:on_ready(function ()
            local opts = { capabilities = capabilities }
            requested_server:setup(opts)
        end)
        if not requested_server:is_installed() then
            -- Queue the server to be installed
            requested_server:install()
        end
    end
end


-- Setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources(
        {{ name = 'nvim_lsp' }, { name = 'vsnip' }}, 
        {{ name = 'buffer' }, { name = 'neorg' }}
    )
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
        ["core.defaults"] = {}, -- Load all the default modules
        -- ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
            }
        },
        ["core.keybinds"] = { -- Configure core.keybinds
            config = {
                default_keybinds = true, -- Generate the default keybinds
                neorg_leader = "<Leader>o" -- This is the default if unspecified
            }
        },
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/neorg"
                }
            }
        }
    },
}

-- personal plugs
dofile(config_path .. '/lua/my/statusline.lua')         -- status & tabline
dofile(config_path .. '/lua/my/playground.lua')         -- temporary stuff


------------------------------ OPTIONS ----------------------------------------

opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.colorcolumn = '80'
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

opt.hlsearch = false
opt.hidden = true
opt.cmdheight = 2
opt.updatetime = 200
opt.shortmess:append('cI')
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.signcolumn = 'yes:1'
opt.nrformats = 'bin,hex,alpha'


------------------------------ MAPPINGS ---------------------------------------
g['mapleader'] = " "
local opts = { noremap=true, silent=true }

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
    return require('telescope.builtin').buffers{}
end)

keymap.set('n', '<leader>fb', function ()
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
        cwd=plugin_path,
        previewer=false,
    }
end)

-- Git
-- keymap.set('n', '<leader>gg', ':vertical Git<cr>')
keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>')
keymap.set('n', '<leader>gb', ':0GlLog!<cr>')


keymap.set('n', '<leader>1', ':Cheat php/')

keymap.set('n', '<leader>wc', '<cmd>wa<bar>only<bar>enew<cr>')
keymap.set('n', '<leader>od', ':lua require("my.laravel").open_adminer()<cr>')

keymap.set('n', '<leader>se', ':vsplit $MYVIMRC<cr>')
keymap.set('n', '<leader>so', ':luafile $MYVIMRC<cr>')

keymap.set('c', '<c-p>', '<up>')
keymap.set('c', '<c-n>', '<down>')

keymap.set('n', '<leader>tt', ':lua require("my.utils").run_nearest_or_last_test()<cr>')
keymap.set('n', '<leader>tf', ':TestFile<cr>')
keymap.set('n', '<leader>tl', ':TestLast<cr>')
keymap.set('n', '<leader>ts', ':TestSuite<cr>')

keymap.set('n', '<leader>te', ':tabe<cr>')

keymap.set('n', '<c-l>', ':<C-u>nohlsearch<cr>')
keymap.set('i', '<c-l>', '<esc>:<C-u>nohlsearch<cr>a')
keymap.set('c', 'w!!', 'w :term sudo tee > /dev/null %', {silent = false})
keymap.set('t', '<c-o>', '<c-\\><c-n>')

keymap.set('v', '<a-y>', '"+y')
keymap.set('n', '<a-p>', '"+p')
keymap.set('v', '<a-p>', '"+p')
keymap.set('i', '<a-p>', '<c-r>+')

keymap.set('n', 'gV', '`[v`]')

-- lsp
keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

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

function augroup(name, definitions)
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
    -- Blade
    'BufNewFile,BufRead *blade.php set ft=html',
    -- Dirvish
    'FileType dirvish nnoremap <buffer> % :edit %',
    'FileType dirvish nnoremap <nowait> <buffer> d :!mkdir %',
    -- Vim wiki
    'BufNewFile,BufRead *.wiki,*.md set ft=vimwiki',

    'FileType vimwiki nmap <buffer> - <Plug>(dirvish_up)',
    'FileType vimwiki nmap <buffer> <c-h> <Plug>VimwikiAddHeaderLevel',
    'FileType vimwiki nmap <buffer> <c-l> <Plug>VimwikiRemoveHeaderLevel',
    'FileType vimwiki nmap <buffer> # <Plug>VimwikiNormalizeLink',
    'FileType vimwiki nnoremap <buffer> <leader>wc <cmd>wa <bar> only <bar> enew<cr>',
    'FileType vimwiki setlocal spell textwidth=79 formatoptions+=t',
    'FileType vimwiki let b:coc_suggest_disable=1',
})

cmd [[ colorscheme nord ]]
