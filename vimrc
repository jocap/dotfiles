" ========================
" VIMRC by John Ankarström
" ========================

" PATHOGEN {{{
call pathogen#infect()
Helptags " generate pathogen helptags
" }}}

" BASIC OPTIONS {{{
set encoding=utf-8
" set cpo+=J " for double spacing after periods
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

" - Nvim
if has("nvim")
    set inccommand=nosplit
endif
if !has("nvim")
    set term=xterm-256color
endif

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
" Note: there are more format options under autocmd
set formatoptions=cqn2j " auto-wrap comments,
                        " allow gq,
                        " recognize numbers lists,
                        " use 2nd line indent for whole paragraph,
                        " join comments in a better way

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
" set guicursor+=a:blinkon0 " disable cursor blinking
" "set transparency=1
" set guioptions=aAce
" set guifont=Menlo:h12

syntax on
filetype plugin indent on
set background=dark
"colorscheme adaryn
"colorscheme wombat
"colorscheme molokai
colorscheme jellybeans+

set cursorline
hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE

if has("gui_macvim")
    " Fullscreen
    set fuoptions=maxhorz,maxvert " what's this?
endif
" }}}

" AUTOCMD {{{

if has("autocmd")
    au VimResized * :wincmd = " resize splits when window is resized

    au VimEnter * NERDTree      " start NERDTree
    au VimEnter * wincmd p      " switch back from NERDTree split
    au VimEnter * NERDTreeClose " close NERDTree

    " File types
    autocmd BufNewFile,BufRead *.rss setfiletype xml
    autocmd BufRead,BufNewFile *.less,*.css setfiletype css
    autocmd BufRead,BufNewFile *.haml set ft=haml
    autocmd BufRead,BufNewFile *.go set ft=go
    autocmd BufRead,BufNewFile *.gss set ft=css

    " Remember last location in file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif

    " Format options
    autocmd FileType * setlocal fo-=r fo-=o
    " ^ don't add new comment on new line after comment

    " vimtex
    autocmd User VimtexEventCompileStopped call KillViewer()

    " - Cursorline {{{
    " - Only show cursorline in the current window and in normal mode

    augroup cline
        au!
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline
    augroup END

    " }}}
    " - Trailing whitespace - not working? {{{
    " - Only shown when not in insert mode

    augroup trailing
        au!
        au InsertEnter * :set listchars-=trail:⌴
    augroup END

    " }}}
    " - Neovim {{{
    if has("nvim")
        " Nothing here, yet
    endif
    " }}}
endif
" }}}

" FUNCTIONS {{{

" - Kill PDF viewer (vimtex)
function! KillViewer()
    call system('killall mupdf')
endfunction

" - Set molokai spell check colors
function! SetSpellColors()
    hi SpellBad cterm=underline ctermfg=red ctermbg=NONE
    hi SpellLocal cterm=underline ctermfg=blue ctermbg=NONE
endfunction
call SetSpellColors()

" - Spell check (remember: ]s, [s, z=, zg)
let g:myLang = 1
let g:myLangList = ['nospell', 'en_gb', 'sv']
function! MySpellLang()
  "loop through languages
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction

" - Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <C-I> :call <SID>SynStack()<CR>

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
if has("nvim")
    let g:vimtex_latexmk_progname = '~/.local/bin/nvr'
endif

" - deoplete
if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif

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
noremap <leader>m ^d$k$a <Esc>pjddk$
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
nnoremap <leader>td :color molokai<CR> :call SetSpellColors()<CR>
" ^ make sure this matches standard color scheme

" - spell check
map <F2> :<C-U>call MySpellLang()<CR>

" - tabs
nnoremap <leader>. :tabprevious<CR>
nnoremap <leader>/ :tabnext<CR>

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
