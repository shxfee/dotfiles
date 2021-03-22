-- neovim config
-- github.com/shxfee
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g

------------------------------ PLUGINS ----------------------------------------
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

cmd [[ packadd packer.nvim ]]
local use = require('packer').use
require('packer').startup(function()
    -- IDE
    use {'wbthomason/packer.nvim', opt = true}
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    use 'tpope/vim-fugitive'
    use 'SirVer/ultisnips'
    use 'justinmk/vim-dirvish'
    use {'vimwiki/vimwiki',  branch = 'dev'}
    use 'janko-m/vim-test'
    use 'jiangmiao/auto-pairs'
    -- use 'kkoomen/vim-doge'
    use 'wakatime/vim-wakatime'
    use 'tpope/vim-dadbod'
    use {'neoclide/coc.nvim', branch = 'release'}
    use 'rafcamlet/coc-nvim-lua'

    -- Vimfu
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'godlygeek/tabular'
    use 'tpope/vim-abolish'
    use 'takac/vim-hardtime'

    -- UI
    use 'sheerun/vim-polyglot'
    use 'nanotech/jellybeans.vim'
    use 'mhartington/oceanic-next'
end)


------------------------------ PLUGIN CONFIG ----------------------------------
g['jellybeans_use_gui_italics'] = 0

g['test#strategy'] = 'neovim'
g['test#neovim#term_position'] = 'split'
g['test#php#phpunit#executable'] = './vendor/bin/phpunit'

g['UltiSnipsEditSplit'] = 'vertical'

g['dirvish_mode'] = [[:sort ,^.*[\/],]]
g['loaded_netrw'] = 1
g['loaded_netrwPlugin'] = 1

g['vimwiki_hl_headers'] = 1
g['vimwiki_conceal_onechar_markers'] = 0
g['vimwiki_folding'] = 'list:quick'

g['coc_global_extensions'] = { 'coc-json', 'coc-phpls', 'coc-tailwindcss', 'coc-css' }

g['AutoPairsShortcutToggle'] = ''
g['AutoPairsMultilineClose'] = 0

-- Lets kick some bad habits
g['hardtime_maxcount'] = 2
g['hardtime_default_on'] = true
g['hardtime_allow_different_key'] = true
g['list_of_normal_keys'] = {"h", "j", "k", "l"}
g['list_of_visual_keys'] = {"h", "j", "k", "l"}
g['list_of_insert_keys'] = {"<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"}
g['list_of_disabled_keys'] = {}

-- telescope
require('telescope').load_extension('fzy_native')


------------------------------ STATUSLINES ------------------------------------
-- Attempt no 69 to create my own statusline
function my_statusline()
    local branch = fn.FugitiveHead()

    if branch and #branch > 0 then
        branch = '  '..branch
    end 

    return branch..'  %f %m%= %{&filetype} %p%% '
end

cmd[[ set statusline=%!luaeval('my_statusline()') ]]


------------------------------ OPTIONS ----------------------------------------
-- A better API for handling options is on the way
-- ref: https://github.com/neovim/neovim/pull/13479
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

cmd [[ colorscheme OceanicNext ]]
-- cmd [[ colorscheme jellybeans ]]

opt('w', 'wrap', false)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'colorcolumn', '80')
opt('o',  'scrolloff', 3)
opt('o',  'termguicolors', true)
opt('o',  'showmode', false)

opt('b', 'smartindent', true)
opt('b', 'shiftwidth', 4)
opt('b', 'tabstop', 4)
opt('b', 'softtabstop', 4)
opt('b', 'expandtab', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)

opt('o', 'winminwidth', 10)
opt('o', 'winwidth', 120)
opt('o', 'inccommand', 'nosplit')
opt('o', 'viewoptions', 'cursor,folds')

opt('o', 'hidden', true)
opt('o', 'cmdheight', 2)
opt('o', 'updatetime', 200)
opt('o', 'shortmess', vim.o.shortmess .. 'cI')
opt('o', 'completeopt', 'menuone,noinsert,noselect')
opt('w', 'signcolumn', 'yes:1')
opt('b', 'nrformats', 'alpha')
opt('b', 'spellfile', '~/.local/share/nvim/spell/en.utf-8.add')


------------------------------ MAPPINGS ---------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

g['mapleader'] = " "
map('n', '<leader>ff', ':lua require("telescope.builtin").find_files{}<cr>', {silent=true})
map('n', '<leader>fd', ':lua require("telescope.builtin").find_files{find_command={"fd", "--type", "d"}}<cr>', {silent=true})
map('n', '<leader>fp', ':lua require("telescope.builtin").planets{}<cr>', {silent=true})
map('n', '<leader>fc', ':lua require("telescope.builtin").colorscheme{}<cr>', {silent=true})

map('n', '<leader>gg', ':vertical Git<cr>')
map('n', '<leader>wc', ':wa<cr>:only<cr>:enew<cr>')
map('n', '<leader>od', ':lua require("my.laravel").open_adminer()<cr>')

map('n', '<leader>se', ':vsplit $MYVIMRC<cr>')
map('n', '<leader>so', ':luafile $MYVIMRC<cr>')

map('c', '<c-p>', '<up>')
map('c', '<c-n>', '<down>')

map('n', '<leader>tt', ':lua require("my.utils").run_nearest_or_last_test()<cr>', {silent=true})
map('n', '<leader>tf', ':TestFile<cr>')
map('n', '<leader>ts', ':TestSuite<cr>')

map('n', '<leader>te', ':tabe<cr>')

map('n', '<c-l>', ':<C-u>nohlsearch<cr>', {silent = true})
map('i', '<c-l>', '<esc>:<C-u>nohlsearch<cr>a', {silent = true})
map('c', 'w!!', 'w :term sudo tee > /dev/null %')
map('t', '<c-o>', '<c-\\><c-n>')

map('v', '<a-y>', '"+y')
map('n', '<a-p>', '"+p')
map('v', '<a-p>', '"+p')
map('i', '<a-p>', '<c-r>+')

map('n', 'gV', '`[v`]')

-- COC maps
map('i', '<c-space>', 'coc#refresh()', {silent = true, expr = true})
map('n', '[g', '<plug>(coc-diagnostic-prev)', {silent = true})
map('n', ']g', '<plug>(coc-diagnostic-next)', {silent = true})
map('n', 'gd', '<plug>(coc-definition)')
map('n', 'K', ':lua require("my.utils").open_documentation()<CR>', {silent = true})

-- Figure this shit out later
-- Include (count)k/j in jump list
api.nvim_exec([[
    nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
    nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
    vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
]], false)


-- Commands
api.nvim_exec([[ command! -nargs=* T split | startinsert | terminal <args> ]], false)


------------------------------ COMMANDS ---------------------------------------
-- Better API for commands and auto commands is being worked on.
-- ref: https://github.com/neovim/neovim/pull/11613
-- ref: https://github.com/neovim/neovim/pull/12378
function augroup(name, definitions)
    cmd('augroup '..name..' | autocmd!')
        vim.tbl_map(function(c) cmd('autocmd '..c) end, definitions)
    cmd'augroup END'
end

augroup('my_commands', {
    -- General
    'TermOpen * setlocal nonumber norelativenumber',
    'BufWritePost init.lua nested luafile $MYVIMRC',
    'BufWritePost init.lua PackerCompile',
    'VimEnter * silent! lua require("my.laravel").set_db_connection_string()',
    'TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 300}',
    -- Narrow indent
    'FileType html,js,vue,blade,vimwiki setlocal shiftwidth=2 tabstop=2 softtabstop=2',
    'FileType css,html,blade,vue let b:coc_additional_keywords = ["-"]',
    -- Restore cursor
    [[ BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |   exe "normal! g`\"" | endif ]],
    -- Vim wiki
    'FileType vimwiki nmap <buffer> - <Plug>(dirvish_up)',
    'FileType vimwiki nmap <buffer> + <Plug>VimwikiRemoveHeaderLevel',
    'FileType vimwiki nmap <buffer> # <Plug>VimwikiNormalizeLink',
    'FileType vimwiki setlocal spell textwidth=79 formatoptions+=t',
    'FileType vimwiki let b:coc_suggest_disable=1',
    -- Dirvish
    'FileType dirvish nnoremap <buffer> % :edit %',
})

augroup('colorscheme_overrides', {
    'ColorScheme * hi StatusLine guibg=#d8dee9 guifg=#343d46',
    'ColorScheme * hi StatusLineNC guibg=#65737e guifg=#343d46',
    'ColorScheme * hi CursorLineNr guibg=#1b2b34 guifg=#d8dee9',
})


------------------------------ TEMP -------------------------------------------
-- Figure this shit out yo!
-- TODO extract this function to lua
api.nvim_exec([[
    vnoremap zy :call CopyFoldHeader()<cr>
    fun! CopyFoldHeader() range
    let @z = ''

    for i in range(a:firstline, a:lastline)
        if i == foldclosed(i) || foldclosed(i) == -1
        let line = substitute(getline(i), '^\s*[*,#,-]\s*\(\[ \]\)*', '', '')
        let @z .= trim(line) . "\n"
        endif
    endfor

    let @+ = @z
    endfun
]], false)
