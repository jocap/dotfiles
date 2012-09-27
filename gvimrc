set guicursor+=a:blinkon0 " disable cursor blinking
"set transparency=1
set guioptions=aAce
set guifont=Menlo:h12

set list
set listchars=tab:▸\ ,eol:¬
set relativenumber
set ruler

set smartindent
set autoindent

set term=xterm-256color

syntax on
colorscheme bclear

" Search highlighting and preferences:
set hlsearch
set incsearch
set ignorecase
set smartcase

" Spaces & tabs:
set ts=4 sts=4 sw=4 expandtab

if has("gui_macvim")
    " Fullscreen
    set fuoptions=maxhorz,maxvert
endif

" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Enable file type detection
    filetype on
 
    " Syntax of these languages is fussy over tabs vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType haml setlocal ts=2 sts=2 sw=2 expandtab
 
    " Customisations based on house-style (arbitrary)
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType haskell setlocal ts=2 sts=2 sw=2 expandtab

    " Change to font that supports bold and italic styles for
    " Markdown and Textile files:
    autocmd FileType markdown,textile setlocal guifont=Menlo:h12

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml
    " Highlight .less files as CSS
    autocmd BufRead,BufNewFile *.less,*.css setfiletype css

    autocmd BufRead,BufNewFile *.haml set ft=haml
endif
