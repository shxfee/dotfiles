-- neovim config
-- github.com/shxfee

-- TODO create cheat.sh plugin
-- TODO include diagnostic jumps in jump list
-- note taking alternative https://github.com/oberblastmeister/neuron.nvim

local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g

------------------------------ PLUGINS ----------------------------------------
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
config_path = fn.stdpath('config')

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

cmd [[ packadd packer.nvim ]]
local use = require('packer').use
require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'hrsh7th/nvim-compe'
    use 'tpope/vim-fugitive'
    use 'justinmk/vim-dirvish'
    use 'wakatime/vim-wakatime'
    use 'hrsh7th/vim-vsnip'
    use 'tpope/vim-dadbod'
    use 'justinmk/vim-sneak'

    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'janko-m/vim-test'
    use 'jiangmiao/auto-pairs'
    use {'vimwiki/vimwiki', branch = 'dev'}
    use 'norcalli/nvim-colorizer.lua' -- color highlights: need to configure

    use 'jwalton512/vim-blade'
    use 'StanAngeloff/php.vim'
    use 'posva/vim-vue'

    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'godlygeek/tabular'
    use 'tpope/vim-abolish'
    use 'takac/vim-hardtime'

    use 'arcticicestudio/nord-vim'
    use 'kyazdani42/blue-moon'
    use 'shxfee/oceanic-next-vim'
    use 'Th3Whit3Wolf/one-nvim'
end)


------------------------------ PLUGIN CONFIG ----------------------------------
g['oceanic_transparent_bg'] = 1

g['test#strategy'] = 'neovim'
g['test#neovim#term_position'] = 'split'
g['test#php#phpunit#executable'] = './vendor/bin/phpunit'

g['dirvish_mode'] = [[:sort ,^.*[\/],]]
g['loaded_netrw'] = 1
g['loaded_netrwPlugin'] = 1

g['vimwiki_hl_headers'] = 1
g['vimwiki_conceal_onechar_markers'] = 0

g['vsnip_snippet_dir'] = config_path .. '/vsnip'
g['vue_pre_processors'] = {}

g['AutoPairsShortcutToggle'] = ''
g['AutoPairsMultilineClose'] = 0

-- kicking some bad habits
g['hardtime_maxcount'] = 2
g['hardtime_default_on'] = true
g['hardtime_allow_different_key'] = true
g['list_of_normal_keys'] = {"h", "j", "k", "l"}
g['list_of_visual_keys'] = {"h", "j", "k", "l"}

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
      'bash', 'css', 'html', 'javascript', 'json', 'jsonc', 'lua',
      'php', 'python', 'query', 'typescript', 'vue',
    },
    indent = { enable = true, disable = { 'blade', 'vue' } },
    highlight = { enable = true, disable = { 'blade' } },
    context_commentstring = { enable = true }
}

-- language server
require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

require'compe'.setup {
  preselect = 'disable';

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = false,
    }
)

cmd[[inoremap <silent><expr> <c-y>      compe#confirm('<c-y>')]]

-- personal plugs
dofile(config_path .. '/lua/my/statusline.lua')         -- status & tabline
dofile(config_path .. '/lua/my/playground.lua')         -- temporary stuff


------------------------------ OPTIONS ----------------------------------------
-- A better API for handling options is on the way
-- ref: https://github.com/neovim/neovim/pull/13479
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

cmd [[ colorscheme oceanicnext ]]

opt('w', 'wrap', false)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'colorcolumn', '80')
opt('o',  'scrolloff', 3)
opt('o',  'termguicolors', true)
opt('o',  'showmode', false)

opt('b', 'autoindent', true)
opt('b', 'smartindent', true)
opt('b', 'shiftwidth', 4)
opt('b', 'tabstop', 4)
opt('b', 'softtabstop', 4)
opt('b', 'expandtab', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)

opt('o', 'winwidth', 100)
opt('o', 'winminwidth', 30)
opt('o', 'inccommand', 'nosplit')
opt('o', 'viewoptions', 'cursor,folds')

opt('o', 'hlsearch', false)
opt('o', 'hidden', true)
opt('o', 'cmdheight', 2)
opt('o', 'updatetime', 200)
opt('o', 'shortmess', vim.o.shortmess .. 'cI')
opt('o', 'completeopt', 'menuone,noinsert,noselect')
opt('w', 'signcolumn', 'yes:1')
opt('b', 'nrformats', 'alpha')


------------------------------ MAPPINGS ---------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true; silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

g['mapleader'] = " "
map('n', '<leader>ff', ':lua require("telescope.builtin").find_files{previewer=false}<cr>')
map('n', '<leader>fd', ':lua require("telescope.builtin").find_files{find_command={"fd", "--type", "d"}, previewer=false}<cr>')
map('n', '<leader>fg', ':lua require("telescope.builtin").live_grep()<cr>')
map('n', '<leader>fc', ':lua require("telescope.builtin").colorscheme{}<cr>')
map('n', '<leader>fb', ':lua require("telescope.builtin").buffers{}<cr>')
map('n', '<leader>fe', ':lua require("telescope.builtin").find_files{previewer=false,cwd=config_path}<cr>')
map('n', '<leader>1', ':Cheat php/', {silent = false})

map('n', '<leader>gg', ':vertical Git<cr>')
map('n', '<leader>wc', ':wa<cr>:only<cr>:enew<cr>')
map('n', '<leader>od', ':lua require("my.laravel").open_adminer()<cr>')

map('n', '<leader>se', ':vsplit $MYVIMRC<cr>')
map('n', '<leader>so', ':luafile $MYVIMRC<cr>')

map('c', '<c-p>', '<up>', {silent = false})
map('c', '<c-n>', '<down>', {silent = false})

map('n', '<leader>tt', ':lua require("my.utils").run_nearest_or_last_test()<cr>')
map('n', '<leader>tf', ':TestFile<cr>')
map('n', '<leader>tl', ':TestLast<cr>')
map('n', '<leader>ts', ':TestSuite<cr>')

map('n', '<leader>te', ':tabe<cr>')

map('n', '<c-l>', ':<C-u>nohlsearch<cr>')
map('i', '<c-l>', '<esc>:<C-u>nohlsearch<cr>a')
map('c', 'w!!', 'w :term sudo tee > /dev/null %', {silent = false})
map('t', '<c-o>', '<c-\\><c-n>')

map('v', '<a-y>', '"+y')
map('n', '<a-p>', '"+p')
map('v', '<a-p>', '"+p')
map('i', '<a-p>', '<c-r>+')

map('n', 'gV', '`[v`]')

-- lsp
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')

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

-- snippets

------------------------------ COMMANDS ---------------------------------------
-- Better API for commands and auto commands is being worked on.
-- ref: https://github.com/neovim/neovim/pull/11613
-- ref: https://github.com/neovim/neovim/pull/12378
cmd [[cabbrev DD DB describe]]
cmd [[cabbrev PI PackerInstall]]
cmd [[cabbrev PU PackerUpdate]]
cmd [[cabbrev PC PackerClean]]
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
    -- Narrow indent
    'FileType css,html,blade,vue let b:coc_additional_keywords = ["-"]',
    -- Restore cursor
    [[ BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |   exe "normal! g`\"" | endif ]],
    -- Dirvish
    'FileType dirvish nnoremap <buffer> % :edit %',
    'FileType dirvish nnoremap <nowait> <buffer> d :!mkdir %',
    -- Vim wiki
    'FileType vimwiki nmap <buffer> - <Plug>(dirvish_up)',
    'FileType vimwiki nmap <buffer> + <Plug>VimwikiRemoveHeaderLevel',
    'FileType vimwiki nmap <buffer> # <Plug>VimwikiNormalizeLink',
    'FileType vimwiki nmap <buffer> <space>wc <NOP>',
    'FileType vimwiki setlocal spell textwidth=79 formatoptions+=t',
    'FileType vimwiki let b:coc_suggest_disable=1',
})


-- Temporary
vim.cmd[[ nnoremap <leader>c :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r') <bar> :vs <bar> exec ":term ./hello \<cr>" ]]
