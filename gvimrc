set guicursor+=a:blinkon0 " disable cursor blinking
"set transparency=1
set guioptions=aAce
set guifont=Menlo:h12

set list
set listchars=tab:▸\ ,eol:¬
set ruler

set number
if exists("+relativenumber")
    set relativenumber
endif
" FYI: Setting both number and relativenumber makes vim show the absolute number for the current line, instead of 0 constantly

set smartindent
set autoindent

set term=xterm-256color

set nocompatible
syntax on
colorscheme badwolf

" Search highlighting and preferences
set hlsearch
set incsearch
set ignorecase
set smartcase

" Spaces & tabs
set ts=4 sts=4 sw=4 expandtab

if has("gui_macvim")
    " Fullscreen
    set fuoptions=maxhorz,maxvert
endif
