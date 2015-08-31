" Maintainer:	Henrique C. Alves (hcarvalhoalves@gmail.com)
" Version:      1.0
" Last Change:	September 25 2008

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mustang"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine   guibg=#2d2d2d ctermbg=236 cterm=none
  hi CursorColumn guibg=#2d2d2d ctermbg=236
  hi MatchParen   guifg=#d0ffc0 guibg=#2f2f2f gui=none ctermfg=157 ctermbg=237 cterm=none
  hi Pmenu 	   	  guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238
  hi PmenuSel 	  guifg=#000000 guibg=#b1d631 ctermfg=0 ctermbg=148
endif

" General colors
hi Cursor 		guifg=none    guibg=#626262 gui=none ctermbg=241
hi Normal 		guifg=#e2e2e5 guibg=#202020 gui=none ctermfg=253 ctermbg=234
hi NonText 		guifg=#808080 guibg=#303030 gui=none ctermfg=244 ctermbg=234
hi LineNr 		guifg=#808080 guibg=#000000 gui=none ctermfg=244 ctermbg=233
hi TabLineFill 	guifg=#808080 guibg=#000000 gui=none ctermfg=233 ctermbg=none
hi TabLine 		guifg=#808080 guibg=#000000 gui=none ctermfg=244 ctermbg=233 cterm=none
hi TabLineSel 	guifg=#808080 guibg=#000000 gui=none ctermfg=244 ctermbg=236 cterm=none
hi StatusLine 	guifg=#d3d3d5 guibg=#444444 gui=none ctermfg=253 ctermbg=238 cterm=italic
hi StatusLineNC guifg=#939395 guibg=#444444 gui=none ctermfg=246 ctermbg=238
hi VertSplit 	guifg=#444444 guibg=#444444 gui=none ctermfg=238 ctermbg=238
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none ctermbg=4   ctermfg=248
hi Title		guifg=#f6f3e8 guibg=none	gui=none ctermfg=254 cterm=none
hi Visual		guifg=#faf4c6 guibg=#3c414c gui=none ctermfg=254 ctermbg=4
hi SpecialKey	guifg=#808080 guibg=#343434 gui=none ctermfg=244 ctermbg=236

" Syntax highlighting
hi Comment 		guifg=#808080 gui=none ctermfg=244
hi Todo 		guifg=#8f8f8f gui=none ctermfg=245
hi String 		guifg=#b1d631 gui=none ctermfg=148
hi Function 	guifg=#ffffff gui=none ctermfg=255
hi Type 		guifg=#7e8aa2 gui=none ctermfg=103
hi Boolean      guifg=#b1d631 gui=none ctermfg=103
hi Statement 	guifg=#7e8aa2 gui=none ctermfg=103
hi PreProc 		guifg=#faf4c6 gui=none ctermfg=103
hi Keyword		guifg=#ff9800 gui=none ctermfg=208
hi Constant 	guifg=#ff9800 gui=none ctermfg=208
hi Number		guifg=#ff9800 gui=none ctermfg=208
hi Special		guifg=#ff9800 gui=none ctermfg=none
hi Identifier 	guifg=#b1d631 gui=none ctermfg=none cterm=none
hi Operator 	guifg=#b1d631 gui=none ctermfg=none cterm=none
hi Todo         guifg=#000000 guibg=#e6ea50 gui=italic ctermfg=0

" Code-specific colors
hi link CtrlPMatch String

hi link vimHiTerm Normal
hi link vimCommentTitle Comment

hi link phpVarSelector Normal
hi link phpMemberSelector Normal
hi link phpDocTags Comment
hi link phpKeyword Boolean

hi link htmlTagName Normal
