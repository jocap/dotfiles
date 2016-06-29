" ========================
" VIMRC by John Ankarström

" - LICENSE --------------
" Do  Whatever   You  Want
" With It  (Hell,  You Can
" Eat  It   If  You  Want)
" - INSPIRED BY ----------
" * Steve Losh
" ========================

" PATHOGEN {{{
call pathogen#infect()
call pathogen#helptags() " (http://vimcasts.org/e/27)
" }}}

" BASIC OPTIONS {{{
set encoding=utf-8
set cpo+=J " for double spacing after periods
set noswapfile
set undofile
set backup
set nocompatible
set modelines=0
set synmaxcol=800 " don't highlight lines over 800 characters
set scrolloff=5 " makes the cursor be 5 lines from the top/bottom when possible
let mapleader = ","

set term=xterm-256color
"set list
set listchars=tab:▸\ ,eol:¬
set ruler

" - Directories
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
" -- Make those folders automatically if they don't already exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" - Indentation and wrapping
set ts=4 sts=4 sw=4 expandtab
set smartindent
set autoindent
set wrap
set textwidth=80
set formatoptions=qrn1j

" - Searching
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

set number
if exists("+relativenumber")
    set relativenumber
endif " FYI: Setting both number and relativenumber makes vim show the absolute number for the current line, instead of 0 constantly

" }}}

" GRAPHICAL OPTIONS {{{
set guicursor+=a:blinkon0 " disable cursor blinking
"set transparency=1
set guioptions=aAce
set guifont=Menlo:h12

syntax on
filetype plugin indent on
set background=dark
"colorscheme adaryn
"colorscheme wombat
colorscheme molokai
set cursorline
hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE

if has("gui_macvim")
    " Fullscreen
    set fuoptions=maxhorz,maxvert
endif
" }}}

" AUTOCMD {{{

if has("autocmd")
    au VimResized * :wincmd = " resize splits when window is resized

    au VimEnter * NERDTree
    au VimEnter * wincmd p

    autocmd BufNewFile,BufRead *.rss setfiletype xml
    autocmd BufRead,BufNewFile *.less,*.css setfiletype css
    autocmd BufRead,BufNewFile *.haml set ft=haml
    autocmd BufRead,BufNewFile *.go set ft=go

    " Remember last location in file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif

    if executable("par")
        autocmd FileType markdown,textile,mail Par()
        command! -nargs=* Par set formatprg=par\ -w50\ -j\ -q
    endif
    autocmd FileType markdown,textile imap <C-S-Z> <Esc>gqip<S-A>

    " - Cursorline {{{
    " - Only show cursorline in the current window and in normal mode

    augroup cline
        au!
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline
    augroup END

    " }}}
    " - Trailing whitespace {{{
    " - Only shown when not in insert mode

    augroup trailing
        au!
        au InsertEnter * :set listchars-=trail:⌴
    augroup END

    " }}}
endif
" }}}

" FUNCTIONS {{{

" - Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <C-I> :call <SID>SynStack()<CR>

" - Tab completion
function! Smart_TabComplete()
  let line = getline('.')                         " curline
  let substr = strpart(line, -1, col('.')+1)      " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
" }}}

" PLUGINS {{{

" - ctrp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" - nerdtree
let g:NERDTreeWinSize = 30
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" ^ quit vim if NERDtree is last buffer

" }}}

" MAPPINGS, COMMANDS, ETC. {{{

"noremap  <buffer> <silent> k gk
"noremap  <buffer> <silent> j gj
noremap + $
nnoremap ö :
vnoremap ö :
nnoremap <leader>r :so $MYVIMRC<cr>:nohl<cr>
nnoremap <leader>l :set list!<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>w gq} " wrap paragraph
map <C-n> :NERDTreeToggle<CR><C-l>
nnoremap <leader>n <C-w>v<C-w>l
" ^ open vertical split
noremap <leader>m ^d$k$pjddk$
" ^ append previous line with current line
noremap ; :
" ^ shift keys are people too
inoremap <CR> <Esc>
" ^ pinkies are people too
command! -nargs=* E e %:p:h/<args>
" ^ :e on steroids, I hear
inoremap <leader>q ><Esc>F<lyt>o</<C-r>"><Esc>O<Tab>
" ^ <htmltag>[TAB] -> <htmltag>...</htmltag>

" - Split switching {{{
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-l> <C-W>l
map <leader>- <C-W><
map <leader>= <C-W>>
map <leader>0 <C-W>l500<C-W>>
" ^ hides split
" }}}

" - Folds {{{
noremap <leader>o zo
noremap <leader>c zc
noremap <leader>O zR
noremap <leader>C zM
" }}}

" }}}

" THINGS THAT MUST COME LAST FOR SOME FREAKING REASON {{{
set foldmethod=marker
" }}}
