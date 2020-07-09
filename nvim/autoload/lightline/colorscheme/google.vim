" =============================================================================
" Filename: autoload/lightline/colorscheme/google.vim
" Author: Hussain Shafeeu
" License: MIT License
" Last Change: 2020-07-09
" =============================================================================
"<
"In order to understand the above codes, you firstly should know how the
"colorschemes work in lightline.vim. Open the following file.
"		autoload/lightline/colorscheme/powerline.vim
"The colorscheme is created by one dictionary: s:p (abbreviation for palette).
"See the value of s:p.normal.right.
">
"	let s:p.normal.right = [ ['gray5', 'gray10'],
"	      \                  ['gray9', 'gray4'],
"	      \                  ['gray8', 'gray2'] ]
"<
"This array corresponds to the structure of g:lightline.active.right. Recall
"the example A.
">
"	" Example A
"	let g:lightline.active.right = [ [ 'lineinfo', 'syntastic' ],
"	      \                          [ 'percent' ],
"	      \                          [ 'fileformat', 'fileencoding', 'filetype' ] ]
"<
"The colors are ([fgcolor, bgcolor):

" Common colors
let s:blue   = [ '#61afef', 75 ]
let s:green  = [ '#98c379', 76 ]
let s:purple = [ '#c678dd', 176 ]
let s:red1   = [ '#e06c75', 168 ]
let s:red2   = [ '#be5046', 168 ]
let s:yellow = [ '#e5c07b', 180 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" Light variant
let s:fg    = [ '#494b53', 238 ]
let s:bg    = [ '#fafafa', 255 ]
let s:gray1 = [ '#494b53', 238 ]
let s:gray2 = [ '#f0f0f0', 255 ]
let s:gray3 = [ '#d0d0d0', 250 ]
let s:green = [ '#98c379', 35 ]

let s:p.inactive.left   = [ [ s:bg,  s:gray3 ], [ s:bg, s:gray3 ] ]
let s:p.inactive.middle = [ [ s:gray3, s:gray2 ] ]
let s:p.inactive.right  = [ [ s:bg, s:gray3 ] ]

" Common
let s:p.normal.left    = [ [ s:bg, s:blue ], [ s:fg, s:gray3 ] ]
let s:p.normal.middle  = [ [ s:fg, s:gray2 ] ]
let s:p.normal.right   = [ [ s:fg, s:gray3 ], [ s:fg, s:gray2 ] ]
let s:p.normal.error   = [ [ s:red2, s:bg ] ]
let s:p.normal.warning = [ [ s:yellow, s:bg ] ]

let s:p.insert.right   = [ [ s:bg, s:fg ], [ s:fg, s:gray3 ] ]
let s:p.insert.left    = [ [ s:bg, s:fg ], [ s:fg, s:gray3 ] ]

let s:p.replace.right  = [ [ s:bg, s:red1 ], [ s:fg, s:gray3 ] ]
let s:p.replace.left   = [ [ s:bg, s:red1 ], [ s:fg, s:gray3 ] ]

let s:p.visual.right   = [ [ s:bg, s:purple ], [ s:fg, s:gray3 ] ]
let s:p.visual.left    = [ [ s:bg, s:purple ], [ s:fg, s:gray3 ] ]

let s:p.tabline.left   = [ [ s:fg, s:gray2 ] ]
let s:p.tabline.tabsel = [ [ s:fg, s:gray3 ] ]
let s:p.tabline.middle = [ [ s:gray3, s:gray2 ] ]
let s:p.tabline.right  = [ [ s:gray2, s:gray2 ] ]

let g:lightline#colorscheme#google#palette = lightline#colorscheme#flatten(s:p)
