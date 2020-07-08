" description:	color scheme based on google's
"      author:	shxfee@gmail.com
"     license:	gpl 3+
"     version:	0.1 (2020-07-09)

set background=light

hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "google"

let s:black        = '#000000'
let s:blue         = '#6694e3'
let s:blue_dark    = '#2a5db0'
let s:blue_light   = '#e0ecff'
let s:green        = '#006633'
let s:green_light  = '#46aa64'
let s:gray         = '#aaaaaa'
let s:gray_light   = '#bdbdbd'
let s:gray_lighter = '#fafafa'
let s:red          = '#d96666'
let s:white        = '#ffffff'
let s:yellow       = '#ffffb5'

hi ColorColumn guibg=#fafafa
hi Cursor 		guifg=#ffffff	guibg=s:black	gui=none
hi CursorLine		          	guibg=#fafafa	gui=none
hi Folded 		guibg=#bdbdbd	guifg=#000000	gui=none
hi CursorLineNr guifg=#0b0b0b	guibg=#ffffff	gui=none
hi Pmenu 		guifg=#ffffff	guibg=#aaaaaa	gui=none
hi PmenuSel 	guifg=#ffffff	guibg=#bdbdbd	gui=none
hi Conceal 		guifg=#aaaaaa	guibg=#ffffff	gui=underline
hi VertSplit	guifg=#aaaaaa	guibg=#f2f2f2	gui=none
hi StatusLine 	guifg=#ffffff	guibg=#f2f2f2	gui=none
hi StatusLineNC guifg=#aaaaaa	guibg=#f2f2f2	gui=none
hi Visual		guifg=#ffffff	guibg=#6694e3	gui=none

hi NonText 		guifg=#f0f0f0	guibg=#ffffff	gui=none
hi Normal 		guifg=#000000	guibg=#ffffff	gui=none
hi Comment 		guifg=#aaaaaa	guibg=none  	gui=none
hi Constant 	guifg=#6694e3	guibg=none  	gui=none
hi DiffAdd		guifg=#ffffff	guibg=#006633	gui=none
hi DiffChange	guifg=#000000	guibg=#ffffb5	gui=none
hi DiffDelete	guifg=#000000	guibg=#d96666	gui=none
hi DiffText		guifg=#d96666	guibg=#ffffb5	gui=none
hi Identifier 	guifg=#7799bb	guibg=none  	gui=none
hi ModeMsg		guifg=#ffffff	guibg=#6694e3	gui=none
hi PreProc 		guifg=#46aa64	guibg=none  	gui=none
hi Search		guifg=#000000	guibg=#ffffb5
hi Special		guifg=#2a5db0	guibg=none  	gui=none
hi Statement 	guifg=#2a5db0	guibg=none  	gui=none
hi Error 		guifg=#ffffff	guibg=#d96666	gui=none
hi Type 		guifg=#006633	guibg=none  	gui=none
hi Underlined	guifg=#6694e3	guibg=none  	gui=underline

hi!	link Macro			PreProc
hi! link Boolean		Constant
hi! link Character		Constant
hi! link Conditional	Statement
hi! link CursorColumn	CursorLine
hi! link Debug			PreProc	
hi! link Define			PreProc
hi! link Delimiter		Identifier
hi! link Directory		Statement
hi! link ErrorMsg		Error
hi! link Exception		Statement
hi! link Float			Constant
hi! link FoldColumn		Folded
hi! link Function		Identifier
hi! link Function		Identifier
hi! link Ignore			Comment
hi! link Include		PreProc
hi! link IncSearch		Search
hi! link Keyword		Identifier
hi! link Keyword		Identifier
hi! link Label			Statement
hi! link LineNr			Comment
hi! link MatchParen		Statement
hi! link MoreMsg		Identifier
hi! link NonText		Comment
hi! link Number			Constant
hi! link Operator		Identifier
hi! link Question		MoreMsg
hi! link PreCondit		PreProc
hi! link Repeat			Statement
hi! link SignColumn		Identifier
hi! link SpecialChar	Special
hi! link SpecialComment	Special
hi! link SpecialKey		Special
hi! link SpellBad		Error
hi! link SpellCap		Error
hi! link SpellLocal		Error
hi! link SpellRare		Error
hi! link StorageClass	Type
hi! link String			Constant
hi! link Structure		Type
hi! link Title			Structure
hi! link Typedef		Type
hi! link WarningMsg		Error
