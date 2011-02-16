" Vim color file
" Converted from Textmate theme Less using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Less"

hi Cursor  guifg=NONE guibg=#91ff00 gui=NONE
hi Visual  guifg=NONE guibg=#b30f49 gui=NONE
hi CursorLine  guifg=NONE guibg=#353637 gui=NONE
hi CursorColumn  guifg=NONE guibg=#353637 gui=NONE
hi LineNr  guifg=#7e827d guibg=#111413 gui=NONE
hi VertSplit  guifg=#3a3e3b guibg=#3a3e3b gui=NONE
hi MatchParen  guifg=#b35e4d guibg=NONE gui=NONE
hi StatusLine  guifg=#ebefe7 guibg=#3a3e3b gui=bold
hi StatusLineNC  guifg=#ebefe7 guibg=#3a3e3b gui=NONE
hi Pmenu  guifg=#6691a0 guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#b30f49 gui=NONE
hi IncSearch  guifg=NONE guibg=#313c33 gui=NONE
hi Search  guifg=NONE guibg=#313c33 gui=NONE
hi Directory  guifg=#b35e4d guibg=NONE gui=NONE
hi Folded  guifg=#3f89da guibg=#111413 gui=NONE

hi phpVarSelector guifg=#738c73 guibg=NONE gui=NONE
hi phpSuperglobal guifg=#738c73 guibg=NONE gui=NONE
hi phpQuoteDouble guifg=#bcd279 guibg=NONE gui=NONE
hi phpQuoteSingle guifg=#bcd279 guibg=NONE gui=NONE
hi Identifier guifg=#738c73 guibg=NONE gui=NONE
hi phpDefineMethodName guifg=#6691a0 guibg=NONE gui=NONE
hi phpDefineFuncName guifg=#6691a0 guibg=NONE gui=NONE
hi phpSpecialMethods guifg=#b35e4d guibg=NONE gui=NONE
hi phpDefineMethod guifg=NONE guibg=NONE gui=NONE
hi phpDefine guifg=NONE guibg=NONE gui=NONE
hi phpFunctions guifg=#b35e4d guibg=NONE gui=NONE
hi phpSemicolon guifg=NONE guibg=NONE gui=NONE

hi Normal  guifg=#ebefe7 guibg=#111413 gui=NONE
hi Boolean  guifg=#b35e4d guibg=NONE gui=NONE
hi Character  guifg=#b35e4d guibg=NONE gui=NONE
hi Comment  guifg=#3f89da guibg=NONE gui=italic
hi Conditional  guifg=#ffee62 guibg=NONE gui=NONE
hi Constant  guifg=#b35e4d guibg=NONE gui=NONE
hi Define  guifg=#b35e4d guibg=NONE gui=NONE
hi ErrorMsg  guifg=#ffffff guibg=#b03c3c gui=NONE
hi WarningMsg  guifg=#ffffff guibg=#b03c3c gui=NONE
hi Float  guifg=#b35e4d guibg=NONE gui=NONE
hi Function  guifg=#6691a0 guibg=NONE gui=NONE
hi Keyword  guifg=#b35e4d guibg=NONE gui=NONE
hi Label  guifg=#bcd279 guibg=NONE gui=NONE
hi NonText  guifg=#404040 guibg=NONE gui=NONE
hi Number  guifg=#b35e4d guibg=NONE gui=NONE
hi Operator  guifg=#b35e4d guibg=NONE gui=NONE
hi PreProc  guifg=#b35e4d guibg=NONE gui=NONE
hi Special  guifg=#ebefe7 guibg=NONE gui=NONE
hi SpecialKey  guifg=#404040 guibg=NONE gui=NONE
hi Statement  guifg=#ffee62 guibg=NONE gui=NONE
hi StorageClass  guifg=NONE guibg=NONE gui=NONE
hi String  guifg=#bcd279 guibg=NONE gui=NONE
hi Tag  guifg=#6691a0 guibg=NONE gui=NONE
hi Title  guifg=#ebefe7 guibg=NONE gui=bold
hi Todo  guifg=#3f89da guibg=NONE gui=inverse,bold
hi Type  guifg=#6691a0 guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#ffee62 guibg=NONE gui=NONE
hi rubyFunction  guifg=#6691a0 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyConstant  guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#bcd279 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#738c73 guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#738c73 guibg=NONE gui=NONE
hi rubyInclude  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#738c73 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#cccc33 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#cccc33 guibg=NONE gui=NONE
hi rubyEscape  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyControl  guifg=#ffee62 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=#738c73 guibg=NONE gui=NONE
hi rubyOperator  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyException  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#738c73 guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#ffee62 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#b35e4d guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#b35e4d guibg=NONE gui=NONE
hi erubyDelimiter  guifg=#6691a0 guibg=NONE gui=NONE
hi erubyComment  guifg=#3f89da guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#b35e4d guibg=NONE gui=NONE
hi htmlTag  guifg=#ffee62 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#ffee62 guibg=NONE gui=NONE
hi htmlTagName  guifg=#ffee62 guibg=NONE gui=NONE
hi htmlArg  guifg=#ffee62 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#b35e4d guibg=NONE gui=NONE
hi javaScriptFunction  guifg=NONE guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#b35e4d guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#6691a0 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#738c73 guibg=NONE gui=NONE
hi yamlAlias  guifg=#738c73 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#bcd279 guibg=NONE gui=NONE
hi cssURL  guifg=#738c73 guibg=NONE gui=NONE
hi cssFunctionName  guifg=#b35e4d guibg=NONE gui=NONE
hi cssColor  guifg=#b35e4d guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#ffee62 guibg=NONE gui=NONE
hi cssClassName  guifg=#ffee62 guibg=NONE gui=NONE
hi cssValueLength  guifg=#b35e4d guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#b35e4d guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE

