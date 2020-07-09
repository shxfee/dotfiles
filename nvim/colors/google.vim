" description:	color scheme based on google's
"      author:	shxfee@gmail.com
"     license:	gpl 3+
"     version:	0.1 (2020-07-09)

set background=light

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "google"

" Sets the highlighting for the given group
fun! s:X(group, fg, bg, attr)
    let highlightstr  = 'highlight ' . a:group . ' '

    let highlightstr .= 'guifg=' . a:fg . ' '
    let highlightstr .= 'guibg=' . a:bg . ' '
    let highlightstr .= 'gui=' . a:attr . ' '

    execute highlightstr
endfunction

" Colors
let s:black        = '#000000'
let s:black_light  = '#0b0b0b'
let s:blue         = '#6694e3'
let s:blue_dark    = '#2a5db0'
let s:blue_light   = '#7799bb'
let s:blue_lighter = '#e0ecff'
let s:green        = '#006633'
let s:green_light  = '#46aa64'
let s:gray_dark    = '#505050'
let s:gray         = '#aaaaaa'
let s:gray_light   = '#d6d6d6'
let s:gray_lighter = '#fafafa'
let s:red          = '#d96666'
let s:white        = '#ffffff'
let s:yellow       = '#ffffb5'

" UI
call s:X("NonText"      , s:gray         , s:white        , "none")
call s:X("Normal"       , s:black        , s:white        , "none")
call s:X("ColorColumn"  , "none",  s:gray_lighter , "none")
call s:X("Cursor"       , s:white        , s:blue        , "none")
call s:X("CursorLine"   , "none"         , s:gray_lighter , "none")
call s:X("Folded"       , s:black        , s:gray_light   , "none")
call s:X("Conceal"      , s:gray         , "none"         , "underline")
call s:X("LineNr"       , s:gray         , s:white        , "none")
call s:X("CursorLineNr" , s:gray_dark    , ""             , "none")
call s:X("VertSplit"    , s:gray         , s:gray_light   , "none")
call s:X("StatusLine"   , s:white        , s:gray         , "none")
call s:X("StatusLineNC" , s:gray         , s:gray         , "none")
call s:X("Visual"       , s:white        , s:blue         , "none")
call s:X("Pmenu"        , s:black_light  , s:gray_light   , "none")
call s:X("PmenuSel"     , s:black_light  , "#ebebeb"      , "none")
call s:X("PmenuSbar"    , s:gray_light   , s:gray_light   , "none")

" Syntax
call s:X("Comment"      , s:gray         , "none"         , "none")
call s:X("Constant"     , s:blue         , "none"         , "none")
call s:X("DiffAdd"      , s:white        , s:green        , "none")
call s:X("DiffChange"   , s:black        , s:yellow       , "none")
call s:X("DiffDelete"   , s:black        , s:red          , "none")
call s:X("DiffText"     , s:red          , s:yellow       , "none")
call s:X("Identifier"   , s:blue_light   , "none"         , "none")
call s:X("ModeMsg"      , s:white        , s:blue         , "none")
call s:X("PreProc"      , s:green_light  , "none"         , "none")
call s:X("Search"       , s:black        , s:yellow       , "none")
call s:X("Special"      , s:blue_dark    , "none"         , "none")
call s:X("Statement"    , s:blue_dark    , "none"         , "none")
call s:X("Error"        , s:white        , s:red          , "none")
call s:X("Type"         , s:green        , "none"         , "none")
call s:X("Underlined"   , s:blue         , "none"         , "underline")


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
