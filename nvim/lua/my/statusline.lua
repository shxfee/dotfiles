require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                path = 1, -- relative
                symbols = {
                    unnamed = '',
                },
            },
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

------------------------------ TAB LINE ---------------------------------------
local fn, cmd = vim.fn, vim.cmd
function My_tabline()
    local s = ''

    for i = 1, fn.tabpagenr('$') do
        local buflist = fn.tabpagebuflist(i)
        local label = fn.bufname(buflist[1])
        label = ' ' .. fn.fnamemodify(label, ':t')

        if label == ' ' then label = ' NA ' end

        if i == fn.tabpagenr() then s = s .. '%#TabLineSel#'
        else s = s .. '%#TabLine#' end
        s = s .. label .. ' '
    end

    s = s .. '%#TabLineFill#%T'
    return s
end

cmd[[ set tabline=%!luaeval('My_tabline()') ]]
