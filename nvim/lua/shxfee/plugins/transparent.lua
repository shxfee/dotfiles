if not pcall(require, 'transparent') then return end

-- Make neovim trasparent
require'transparent'.setup{
    enable = true;
    extra_groups = {
        'WinSeparator',
        'VertSplit',
        'TabLine',
        'TabLineFill',
        'Pmenu',
        'PmenuSel',
        'Folded',
    };
}
