" =============================================================================
" Filename: autoload/lightline/colorscheme/google.vim
" Author: Hussain Shafeeu
" License: MIT License
" Last Change: 2020-07-09
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'tabline': {}}

let s:gray_dark    = [ '#505050', 250 ]
let s:gray         = [ '#aaaaaa', 238 ]
let s:gray_light   = [ '#d6d6d6', 250 ]
let s:gray_lighter = [ '#fafafa', 255 ]
let s:blue         = [ '#61afef', 75 ]


let s:p.normal.left    = [ [ s:gray_lighter, s:blue ], [ s:gray_lighter, s:gray_dark ], [ s:gray_dark, s:gray_light ] ]
let s:p.normal.middle  = [ [ s:gray_dark, s:gray_light ] ]
let s:p.normal.right   = [ [ s:gray_dark, s:gray ], [ s:gray_dark, s:gray_light ] ]

" Inactive
let s:p.inactive.left   = [ [ s:gray_lighter, s:gray_light ] ]
let s:p.inactive.middle = copy(s:p.inactive.left)
let s:p.inactive.right  = copy(s:p.inactive.left)

let s:p.tabline.left   = [ [ s:gray_dark, s:gray_light ] ]
let s:p.tabline.tabsel = [ [ s:gray_dark, s:gray_lighter ] ]
let s:p.tabline.middle = [ [ s:gray_dark, s:gray_light ] ]
let s:p.tabline.right  = [ [ s:gray_light, s:gray_light ] ]

let g:lightline#colorscheme#google#palette = lightline#colorscheme#flatten(s:p)
