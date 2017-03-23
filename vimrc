" ========================
" VIMRC by John Ankarström
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
set showcmd
set laststatus=2 " always show status bar
set synmaxcol=800 " don't highlight lines over 800 characters
set scrolloff=5 " makes the cursor be 5 lines from the top/bottom when possible
set mouse=a
let mapleader = ","
let maplocalleader = "\\" " \

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

" - Splits
set splitright " split right instead of left
set splitbelow " vsplit below instead of above

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

" - Spell check
set nospell
set spelllang=en_us

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

hi SpellBad cterm=underline ctermfg=red ctermbg=NONE
" ^ spell check

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
    autocmd BufRead,BufNewFile *.gss set ft=css

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

let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/]node_modules$',
\ }

" - nerdtree
let g:NERDTreeWinSize = 30
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" ^ quit vim if NERDtree is last buffer

" - nerdcommenter
let g:NERDSpaceDelims = 1
:let g:NERDCustomDelimiters = {
\ 'html': { 'left': '<!-- ', 'right': '-->', 'leftAlt': '/*', 'rightAlt': '*/' }
\ }
" ^ html files: html comments + alt. css/javascript comments

" - vimtex
let g:tex_flavor = 'latex' " not specific to vimtex, but good nonetheless
let g:vimtex_format_enabled = 1 " make gq work properly
let g:vimtex_fold_manual = 1 " support folding on demand
let g:vimtex_view_method = 'mupdf'

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
noremap <leader>m ^d$k$pjddk$
" ^ append previous line with current line
noremap ; :
" ^ shift keys are people too
inoremap <CR> <Esc>
" ^ fingers are people too
command! -nargs=* E e %:p:h/<args>
" ^ :e on steroids, I hear
inoremap <leader>q ><Esc>F<lyt>o</<C-r>"><Esc>O<Tab>
" ^ <htmltag[leader-q] -> <htmltag>...</htmltag>

" - node.js reload server (webfaction)
nnoremap <leader>S :!./bin/stop<cr>:!./bin/start<cr>

" - paste/nopaste
nnoremap <leader>p :set paste<cr>
inoremap <leader>p <Esc>:set paste<cr>i
nnoremap <leader>pp :set nopaste<cr>
inoremap <leader>pp <Esc>:set nopaste<cr>i
" ^ ,pp doesn't work in paste insert mode, obviously, so it is useless... i'll
" leave it for now, though, might switch to ctrl instead in the future.

" - swedish letters
inoremap <leader>[ å
inoremap <leader>' ä
inoremap <leader>; ö

" - switch color schemes (light/dark)
nnoremap <leader>tl :color tabula<CR>:hi CursorLine cterm=NONE<CR>
nnoremap <leader>td :color molokai<CR> :hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE<CR>
" ^ make sure this matches standard color scheme

" - spell check (remember: ]s, [s, z=, zg)
let g:myLang = 1
let g:myLangList = ['nospell', 'en_us', 'sv']
function! MySpellLang()
  "loop through languages
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
map <F2> :<C-U>call MySpellLang()<CR>

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
noremap <leader>O zR
noremap <leader>C zM
" }}}

" }}}

" THINGS THAT MUST COME LAST FOR SOME FREAKING REASON {{{
set foldmethod=marker
" }}}
