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
colorscheme leo

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

if has("autocmd")
    " Change to font that supports bold and italic styles for
    " Markdown and Textile files:
    autocmd FileType markdown,textile setlocal guifont=Menlo:h12
endif
