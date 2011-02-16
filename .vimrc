let mapleader = ","

set guicursor+=a:blinkon0 " disable cursor blinking
set transparency=1
set guioptions=aAce
set guifont=Linefeed:h12

set foldmethod=marker " {{{}}}

set number ruler

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

set ts=2 sts=2 sw=2 expandtab " spaces & tabs

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on
 
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
 
  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 noexpandtab  
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
 
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  autocmd BufRead,BufNewFile *.less,*.css setfiletype css " highlight .less files as CSS

endif

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert
endif

" Start without the toolbar
set guioptions-=T

" Default gui color scheme
colorscheme less
