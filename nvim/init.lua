-- neovim config
-- github.com/shxfee

-- TODO setup proper diagnostic navigation
-- TODO setup auto formatters and prettiers for lsp
-- TODO fix indent on last line PHP
-- TODO include diagnostic jumps in jump list
-- TODO extract dadbod auto configuration to a plugin

local api, cmd, fn, g, opt = vim.api, vim.cmd, vim.fn, vim.g, vim.opt

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

    use 'windwp/nvim-ts-autotag'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'janko-m/vim-test'
    use 'windwp/nvim-autopairs'
    use {'vimwiki/vimwiki', branch = 'dev'}
    use 'norcalli/nvim-colorizer.lua' -- color highlights: need to configure

    -- use 'shxfee/vim-blade'
    use 'StanAngeloff/php.vim'
    use 'posva/vim-vue'

    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'godlygeek/tabular'
    use 'tpope/vim-abolish'

    use 'arcticicestudio/nord-vim'
    use 'kyazdani42/blue-moon'
    use 'shxfee/oceanic-next-vim'
    use 'Th3Whit3Wolf/one-nvim'

end)

-- reload my modules
require('plenary.reload').reload_module('my', true)


------------------------------ PLUGIN CONFIG ----------------------------------
g['oceanic_transparent_bg'] = 1

g['test#strategy'] = 'neovim'
g['test#neovim#term_position'] = 'split'
g['test#php#phpunit#executable'] = './vendor/bin/phpunit'

g['dirvish_mode'] = [[:sort ,^.*[\/],]]
-- g['loaded_netrw'] = 1
-- g['loaded_netrwPlugin'] = 1

g['vimwiki_hl_headers'] = 1
g['vimwiki_conceal_onechar_markers'] = 0
g['vimwiki_global_ext'] = 0
g['indent_blankline_show_trailing_blankline_indent'] = false

g['vsnip_snippet_dir'] = config_path .. '/vsnip'
g['vue_pre_processors'] = {}

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
    indent = { enable = true, disable = { 'html', 'vue' } },
    highlight = { enable = true, disable = { 'vue' } },
    context_commentstring = { enable = true },
    autotag = {
        enable = true,
        filetypes = { 'php', 'html', 'vue' },
    },
}

-- language server
if g['loaded_lsp'] ~= true then
    require'lspinstall'.setup()

    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
        require'lspconfig'[server].setup{}
    end
end

g['loaded_lsp'] = true
g['indent_blankline_char'] = '│'
g['indent_blankline_use_treesitter'] = true

-- auto complete
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

-- autopairs
require('nvim-autopairs').setup()

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
opt.nrformats = 'alpha'


------------------------------ MAPPINGS ---------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true; silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

g['mapleader'] = " "
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files{previewer=false}<cr>')
map('n', '<leader>fd', '<cmd>lua require("telescope.builtin").find_files{find_command={"fd", "--type", "d"}, previewer=false}<cr>')
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map('n', '<leader>fc', '<cmd>lua require("telescope.builtin").colorscheme{}<cr>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers{}<cr>')
map('n', '<leader>fe', '<cmd>lua require("telescope.builtin").find_files{previewer=false,cwd=config_path}<cr>')
map('n', '<leader>1', ':Cheat php/', {silent = false})

map('n', '<leader>gg', ':vertical Git<cr>')
map('n', '<leader>wc', '<cmd>wa<bar>only<bar>enew<cr>')
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
map('n', '[d', "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
map('i', '<cr>', 'luaeval("require(\\"nvim-autopairs\\").autopairs_cr()")', {expr = true , noremap = true})

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
    'FileType vimwiki nmap <buffer> + <Plug>VimwikiRemoveHeaderLevel',
    'FileType vimwiki nmap <buffer> # <Plug>VimwikiNormalizeLink',
    'FileType vimwiki nnoremap <buffer> <leader>wc <cmd>wa <bar> only <bar> enew<cr>',
    'FileType vimwiki setlocal spell textwidth=79 formatoptions+=t',
    'FileType vimwiki let b:coc_suggest_disable=1',
})


-- Temporary
vim.cmd[[ nnoremap <leader>jt :lua require('my.journal').open_todays_entry()<cr> ]]
vim.cmd[[ nnoremap <leader>jj :lua require('my.journal').list_all_entries()<cr> ]]
vim.cmd[[ nnoremap <leader>c :lua require('my.utils').compile_and_run_c()<cr> ]]
cmd [[ colorscheme oceanicnext ]]
