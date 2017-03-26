" ========================
" VIMRC by John Ankarström
" ========================

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

let g:dark_color = 'jellybeans'
let g:light_color = 'calmar256-light'

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

    " - File types {{{
    augroup filetypes
        autocmd BufNewFile,BufRead *.rss setfiletype xml
        autocmd BufRead,BufNewFile *.less,*.css setfiletype css
        autocmd BufRead,BufNewFile *.haml set ft=haml
        autocmd BufRead,BufNewFile *.go set ft=go
        autocmd BufRead,BufNewFile *.gss set ft=css
    augroup END " }}}

    " - Remember last location in file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif

    " - Format options
    autocmd FileType * setlocal fo-=r fo-=o
    " ^ don't add new comment on new line after comment

    " - vimtex
    autocmd User VimtexEventCompileStopped,VimtexEventQuit call KillViewer()
    " ^ kill pdf viewer when compilation stops or latex file is closed

    " - Only show cursorline in the current window and in normal mode {{{
    augroup cline
        au!
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline
    augroup END " }}}

    " - Neovim-specific {{{
    if has("nvim")
        " Nothing here, yet
    endif " }}}
endif
" }}}

" FUNCTIONS {{{

" - Show syntax highlighting groups for word under cursor {{{
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <C-I> :call <SID>SynStack()<CR>
" }}}

" - Spell check (remember: ]s, [s, z=, zg) {{{
let g:myLang = 1
let g:myLangList = ['nospell', 'en_gb', 'sv']
function! MySpellLang()
  " loop through languages:
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction " }}}

" - Kill PDF viewer (for vimtex) {{{
function! KillViewer()
    call system('killall mupdf 2> /dev/null')
endfunction " }}}

" - Set spell check colors (for colorschemes that don't have sensible defaults) {{{
function! SetSpellColors()
    hi SpellBad cterm=underline ctermfg=red ctermbg=NONE
    hi SpellLocal cterm=underline ctermfg=blue ctermbg=NONE
endfunction
" }}}

" - Between 06-18, use light color - other times, use dark color {{{
" - (to change manually, see mappings <leader>td and <leader>tl)
function! DarkColor()
    execute 'colorscheme ' . g:dark_color
    call SetSpellColors() " if needed
endfunction
function! LightColor()
    execute 'colorscheme ' . g:light_color
    call SetSpellColors() " if needed
endfunction
function! SetColor()
    let l:hour = system('date +%H')
    if (l:hour > 6 && l:hour < 18)
        call LightColor()
    else
        call DarkColor()
    endif
endfunction
call SetColor()
" }}}

" - Function that jumps forward/back to n% of the current line {{{
function! GoPartLine(n)
    let l:line = getline('.')
    let l:line = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '') " remove whitespace
    let l:lineln = strlen(l:line)
    if a:n == 0
        let l:position = 0
    else
        let l:quotient = round(l:lineln * a:n)
        let l:position = float2nr(l:quotient)
    endif

    execute 'normal! ^' . l:position . 'l'
endfunction " }}}

" }}}

" PLUGINS {{{

" Loading {{{
call plug#begin('~/.vim/plugins')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " snippets for UltiSnips
Plug 'kana/vim-submode'
call plug#end()

" }}}

" Configuration {{{

" - NERDtree {{{
let g:NERDTreeWinSize = 30
map <C-n> :NERDTreeToggle<CR><C-l>
" }}}

" - NERDcommenter {{{
let g:NERDSpaceDelims = 1
:let g:NERDCustomDelimiters = {
\ 'html': { 'left': '<!-- ', 'right': '-->', 'leftAlt': '/*', 'rightAlt': '*/' }
\ }
" ^ html files: html comments + alt. css/javascript comments
" }}}

" - vimtex {{{
let g:tex_flavor = 'latex' " not specific to vimtex, but good nonetheless
let g:vimtex_format_enabled = 1 " make gq work properly
let g:vimtex_fold_manual = 1 " support folding on demand
let g:vimtex_view_method = 'mupdf'
if has("nvim")
    let g:vimtex_latexmk_progname = '~/.local/bin/nvr'
endif
" }}}

" - deoplete {{{
if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif
" }}}

" - fzf {{{
nnoremap <c-p> :Files<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}

" - UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
nnoremap <leader>s :call UltiSnips#ListSnippets()<CR>
" }}}

" - submode
let g:submode_keep_leaving_key = 1 " leave submode by pressing any other key

" }}}

" }}}

" MAPPINGS {{{

nnoremap <leader>r :so $MYVIMRC<cr>:nohl<cr>
nnoremap <leader>l :set list!<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>w gq}
noremap <leader>m ^d$k$a <Esc>pjddk$
" ^ append previous line with current line
noremap ; :
inoremap <CR> <Esc>
command! -nargs=* E e %:p:h/<args>
" ^ :e on steroids, I hear

" - paste/nopaste {{{
if !has('nvim') " not needed in neovim (AFAIK)
    nnoremap <leader>p :set paste<cr>
    inoremap <leader>p <Esc>:set paste<cr>i
    nnoremap <leader>pp :set nopaste<cr>
endif
" }}}

" - Swedish letters {{{
inoremap <leader>[ å
inoremap <leader>' ä
inoremap <leader>; ö
" }}}

" - Switch color schemes (light/dark)
nnoremap <leader>tl :call LightColor()<CR>
nnoremap <leader>td :call DarkColor()<CR>
" ^ make sure this matches standard color scheme

" - Spell check
map <F2> :<C-U>call MySpellLang()<CR>

" - Tabs
nnoremap <leader>. :tabprevious<CR>
nnoremap <leader>/ :tabnext<CR>

" - Folds
noremap <leader>O zR
noremap <leader>C zM

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

" }}}

" SUBMODES {{{

" - linejump {{{
" - Enter submode with <space>n, where n*10 is the % of the current line you
"   want to jump to (for more information, see GoPartLine(n) function).
call submode#enter_with('linejump', 'n', '', '<space>`', ':call GoPartLine(0)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>1', ':call GoPartLine(0.1)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>2', ':call GoPartLine(0.2)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>3', ':call GoPartLine(0.3)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>4', ':call GoPartLine(0.4)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>5', ':call GoPartLine(0.5)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>6', ':call GoPartLine(0.6)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>7', ':call GoPartLine(0.7)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>8', ':call GoPartLine(0.8)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>9', ':call GoPartLine(0.9)<CR>')
call submode#enter_with('linejump', 'n', '', '<space>0', ':call GoPartLine(1)<CR>')

call submode#map('linejump', 'n', '', '`', ':call GoPartLine(0)<CR>')
call submode#map('linejump', 'n', '', '1', ':call GoPartLine(0.1)<CR>')
call submode#map('linejump', 'n', '', '2', ':call GoPartLine(0.2)<CR>')
call submode#map('linejump', 'n', '', '3', ':call GoPartLine(0.3)<CR>')
call submode#map('linejump', 'n', '', '4', ':call GoPartLine(0.4)<CR>')
call submode#map('linejump', 'n', '', '5', ':call GoPartLine(0.5)<CR>')
call submode#map('linejump', 'n', '', '6', ':call GoPartLine(0.6)<CR>')
call submode#map('linejump', 'n', '', '7', ':call GoPartLine(0.7)<CR>')
call submode#map('linejump', 'n', '', '8', ':call GoPartLine(0.8)<CR>')
call submode#map('linejump', 'n', '', '9', ':call GoPartLine(0.9)<CR>')
call submode#map('linejump', 'n', '', '0', ':call GoPartLine(1)<CR>')
" }}}

" }}}

" THINGS THAT MUST COME LAST FOR SOME REASON {{{
set foldmethod=marker
" }}}
