set guicursor+=a:blinkon0 " disable cursor blinking
set transparency=1
set guioptions=aAce
set guifont=Linefeed:h12
colorscheme less

" Search highlighting and preferences:
set hlsearch
set incsearch
set ignorecase
set smartcase

" Activate folding:
set foldmethod=marker " {{{}}}

" Activate line numbers and rulers:
set number ruler

" Use the same symbols as TextMate for tabstops and EOLs:
set list
set listchars=tab:▸\ ,eol:¬
" Shortcut to rapidly toggle `set list`:
nmap <leader>l :set list!<CR>

" Spaces & tabs:
set ts=2 sts=2 sw=2 expandtab

if has("gui_macvim")
  " Fullscreen
  set fuoptions=maxhorz,maxvert
endif

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
  " Highlight .less files as CSS
  autocmd BufRead,BufNewFile *.less,*.css setfiletype css
endif
