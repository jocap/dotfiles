" Vim color file
" Converted from Textmate theme Boilerplate using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Boilerplate"

hi Cursor  guifg=NONE guibg=#91ff00 gui=NONE
hi Visual  guifg=NONE guibg=#b30f49 gui=NONE
hi CursorLine  guifg=NONE guibg=#353637 gui=NONE
hi CursorColumn  guifg=NONE guibg=#353637 gui=NONE
hi LineNr  guifg=#888a89 guibg=#111413 gui=NONE
hi VertSplit  guifg=#3e4140 guibg=#3e4140 gui=NONE
hi MatchParen  guifg=#b83e3e guibg=NONE gui=NONE
hi StatusLine  guifg=#ffffff guibg=#3e4140 gui=bold
hi StatusLineNC  guifg=#ffffff guibg=#3e4140 gui=NONE
hi Pmenu  guifg=#b83e3e guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#b30f49 gui=NONE
hi IncSearch  guifg=NONE guibg=#5e4c17 gui=NONE
hi Search  guifg=NONE guibg=#5e4c17 gui=NONE
hi Directory  guifg=#ffac45 guibg=NONE gui=NONE
hi Folded  guifg=#3f89da guibg=#111413 gui=NONE

hi phpVarSelector guifg=#ffac45 guibg=NONE gui=NONE
hi phpQuoteDouble guifg=#00c225 guibg=NONE gui=NONE
hi phpQuoteSingle guifg=#00c225 guibg=NONE gui=NONE


hi Normal  guifg=#ffffff guibg=#111413 gui=NONE
hi Macro  guifg=#ffffff guibg=NONE gui=NONE
hi Boolean  guifg=#ffac45 guibg=NONE gui=NONE
hi Character  guifg=#ffac45 guibg=NONE gui=NONE
hi Comment  guifg=#3f89da guibg=NONE gui=italic
hi Conditional  guifg=#fabd1e guibg=NONE gui=NONE
hi Constant  guifg=#ffac45 guibg=NONE gui=NONE
hi Define  guifg=#b83e3e guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#b03c3c gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#b03c3c gui=NONE
hi Float  guifg=#ffac45 guibg=NONE gui=NONE
hi Function  guifg=#b83e3e guibg=NONE gui=NONE
hi Identifier  guifg=#ffac45 guibg=NONE gui=NONE
hi Keyword  guifg=#b83e3e guibg=NONE gui=NONE
hi Label  guifg=#00c225 guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=#353637 gui=NONE
hi Number  guifg=#ffac45 guibg=NONE gui=NONE
hi Operator  guifg=#b83e3e guibg=NONE gui=NONE
hi PreProc  guifg=#b83e3e guibg=NONE gui=NONE
hi Special  guifg=#ffffff guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=#353637 gui=NONE
hi Statement  guifg=#fabd1e guibg=NONE gui=NONE
hi StorageClass  guifg=NONE guibg=NONE gui=NONE
hi String  guifg=#00c225 guibg=NONE gui=NONE
hi Tag  guifg=#b83e3e guibg=NONE gui=NONE
hi Title  guifg=#ffffff guibg=NONE gui=bold
hi Todo  guifg=#3f89da guibg=NONE gui=inverse,bold,italic
hi Type  guifg=#b83e3e guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#fabd1e guibg=NONE gui=NONE
hi rubyFunction  guifg=#b83e3e guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#ffac45 guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#00c225 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#b83e3e guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#ffac45 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#cccc33 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#cccc33 guibg=NONE gui=NONE
hi rubyEscape  guifg=#ffac45 guibg=NONE gui=NONE
hi rubyControl  guifg=#fabd1e guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#b83e3e guibg=NONE gui=NONE
hi rubyException  guifg=#b83e3e guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#cccc33 guibg=NONE gui=bold
hi rubyRailsARAssociationMethod  guifg=#b83426 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#b83426 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#b83426 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#b83426 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=#b83e3e guibg=NONE gui=NONE
hi erubyComment  guifg=#3f89da guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#b83426 guibg=NONE gui=NONE
hi htmlTag  guifg=#fabd1e guibg=NONE gui=NONE
hi htmlEndTag  guifg=#fabd1e guibg=NONE gui=NONE
hi htmlTagName  guifg=#fabd1e guibg=NONE gui=NONE
hi htmlArg  guifg=#fabd1e guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#ffac45 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#b83426 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#b83e3e guibg=NONE gui=NONE
hi yamlAnchor  guifg=#ffac45 guibg=NONE gui=NONE
hi yamlAlias  guifg=#ffac45 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#00c225 guibg=NONE gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=#b83426 guibg=NONE gui=NONE
hi cssColor  guifg=#ffac45 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#fabd1e guibg=NONE gui=NONE
hi cssClassName  guifg=#fabd1e guibg=NONE gui=NONE
hi cssValueLength  guifg=#ffac45 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#ffac45 guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE

