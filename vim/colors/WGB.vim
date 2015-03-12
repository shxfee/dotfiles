" Vim color file " Maintainer:   shxfee <shxfee@gmail.com>
" Last Change: 2014-09-27 00:28:00
" URL: http://github.com/shxfee/dotfiles/WGB.vim

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "WGB"


"General Editor highlights
highlight LineNr ctermfg=243 ctermbg=233 cterm=none
highlight CursorLineNr ctermfg=249 ctermbg=235 cterm=none
highlight CursorLine ctermbg=237 cterm=none
highlight Visual ctermbg=238 cterm=none
highlight VertSplit ctermbg=237 ctermfg=237 cterm=none
highlight ColorColumn ctermbg=237 ctermfg=237 cterm=none

" Main Highlight Groups
hi Normal ctermbg=236 ctermfg=white cterm=none
hi Constant ctermfg=white cterm=none
hi Special ctermfg=white cterm=none

hi Comment ctermfg=243 cterm=none
hi PreProc ctermfg=grey cterm=none

hi Identifier ctermfg=green cterm=none

hi Statement ctermfg=blue cterm=none
hi Type ctermfg=blue cterm=none


" Language Specific overrides
" White & Bold
hi Delimiter ctermfg=15 cterm=bold		"Selects <?php opening in PHP
hi link pythonBuiltinFunc  Delimiter

" White
hi link Operator Normal					"Selects =, ::, =>
hi link Function Normal					"Selects function names
hi link phpMemberSelector Normal		"Selects -> in PHP
hi link javascriptBraces Normal			"Selects { } in JS
hi link vimOption Normal
hi link vimGroup Normal


" Green
hi link phpVarSelector Identifier		"Selects $ in PHP
hi link pythonString Identifier
hi link pythonStrFormatting Identifier
hi link pythonStrFormat Identifier


" Orange
hi Number ctermfg=214 cterm=none
hi link javascriptStringS Number
hi link javascriptStringD Number
hi link cssColor Number


" Blue
hi link Define Statement				"Selects function keyword in PHP
hi link	Boolean Statement				"Selects var keyword in JS
hi link javascriptIdentifier Statement	"Selects var keyword in JS
hi link javascriptFunction Statement	"Selects function keyword in JS
hi link htmlEndTag Statement			"Selects </> of tags in HTML
hi link htmlTag Statement				"Selects all tags in HTML
hi link htmlTagN Statement				"Selects custom tags in HTML
hi link pythonBuiltinObj Statement
hi link pythonOperator Statement

