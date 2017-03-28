" =============================================================================
"                           VIMRC: by John Ankarström
" =============================================================================

" PLUGINS ------------------------------------------------------------------{{{

" Loading ------------------------------------------------------------------{{{
call plug#begin('~/.vim/plugins')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'kana/vim-submode' | Plug '/home/john/.vim/dev/plugins/jumpinline.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'ap/vim-css-color'

if has('nvim')
    Plug 'Shougo/deoplete.nvim'
    Plug 'SirVer/ultisnips' | Plug 'jocap/vim-snippets'
endif
call plug#end()

" --------------------------------------------------------------------------}}}

" Configuration ------------------------------------------------------------{{{

" NERDtree {{{
let g:NERDTreeWinSize = 30
nnoremap <silent> <C-n> :<C-U>NERDTreeToggle<CR><C-l>
" }}}

" NERDcommenter {{{
let g:NERDSpaceDelims = 1
:let g:NERDCustomDelimiters = {
\ 'html': { 'left': '<!-- ', 'right': '-->', 'leftAlt': '/*', 'rightAlt': '*/' }
\ }
" ^ html files: html comments + alt. css/javascript comments
" }}}

" vimtex {{{
let g:tex_flavor = 'latex' " not specific to vimtex, but good nonetheless
let g:vimtex_format_enabled = 1 " make gq work properly
let g:vimtex_fold_manual = 1 " support folding on demand
let g:vimtex_view_method = 'mupdf'
if has("nvim")
    let g:vimtex_latexmk_progname = '~/.local/bin/nvr'
endif
" }}}

" deoplete {{{
if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif
" }}}

" fzf {{{
nnoremap <silent> <space><space> :<C-U>Files<CR>
nnoremap <silent> <space>b :<C-U>Buffers<CR>
nnoremap <silent> <space>l :<C-U>BLines<CR>
nnoremap <silent> <space>h :<C-U>History<CR>
nnoremap <silent> <space>c :<C-U>call fzf#vim#command_history({'right': '40'})<CR>
nnoremap <silent> <space>, :<C-U>call fzf#vim#search_history({'right': '40'})<CR>

inoremap <c-x><c-l> <plug>(fzf-complete-line)

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit' }

if has('nvim')
    let g:fzf_layout = { 'window': 'enew' }
    " ^ open fzf buffer in whole window

    let g:fzf_nvim_statusline = 0
    " ^ hide ugly statusline
endif
" }}}

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
nnoremap <silent> <leader>s :<C-U>call UltiSnips#ListSnippets()<CR>
" }}}

" submode {{{
let g:submode_keep_leaving_key = 1 " leave submode by pressing any other key
" }}}

" vCoolor {{{
let g:vcoolor_lowercase = 1 " lowercase hex colors
" }}}

" --------------------------------------------------------------------------}}}

" }}}

" BASIC OPTIONS ------------------------------------------------------------{{{
set encoding=utf-8
set undofile          " enable persistent undo
set backup            " enable backups
set nocompatible      " disable vi compatibility
set nomodeline        " disable parsing of :set command at BOF and EOF
set showcmd           " display command letters pressed in lower-right corner
set laststatus=2      " always show status bar
set synmaxcol=800     " don't highlight lines over 800 characters
set scrolloff=5       " always keep margin of 5 lines minimum above/below cursor
set mouse=a           " mouse mode
set foldmethod=marker " {{{ fold }}}
set ruler             " show line number, position in line, etc.
let mapleader = ","
let maplocalleader = "\\" " \

set listchars=tab:▸\ ,eol:¬ " characters to use with :set list (<leader>l)

if has("nvim") " neovim
    set inccommand=split " live-preview for searching and substitution
else
    set term=xterm-256color
endif

" Splits:
set splitright " split right instead of left
set splitbelow " vsplit below instead of above

" Spell check:
set nospell         " can be enabled later with SpellCheck()
set spelllang=en_gb " I usually code in en_us, but write in en_gb

" Searching {{{
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
" }}}

" Line numbers {{{
set number " enable line numbers
if exists("+relativenumber")
    set relativenumber " enable relative line numbers
endif
" NOTE: Setting both number and relativenumber makes vim show the absolute
"       number for the current line, instead of 0, and the relative numbers for
"       all other lines.
" }}}

" Directories {{{
set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files

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
" }}}

" Indentation and wrapping {{{
set ts=4 sts=4 sw=4 expandtab
set smartindent
set autoindent
set wrap
set textwidth=79
set formatoptions=cqn2j " auto-wrap comments,
                        " allow gq,
                        " recognize numbers lists,
                        " use 2nd line indent for whole paragraph,
                        " join comments in a better way
" Note: there are more format options under autocmd
" }}}

" }}}

" GRAPHICAL OPTIONS --------------------------------------------------------{{{
syntax on
filetype plugin indent on
set background=dark
set cursorline

let g:dark_color = 'jellybeans'
let g:dark_color_options = ['hi CursorLine cterm=NONE ctermfg=NONE ctermbg=237']
let g:light_color = 'calmar256-light'

" }}}

" AUTOCMD ------------------------------------------------------------------{{{
if has("autocmd")
    au VimResized * :wincmd = " resize splits when window is resized

    " Remember last location in file:
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif

    " Format options:
    autocmd FileType * setlocal fo-=r fo-=o
    " ^ don't add new comment on new line after comment

    " vimtex:
    autocmd User VimtexEventCompileStopped,VimtexEventQuit call KillViewer()
    " ^ kill pdf viewer when compilation stops or latex file is closed

    " File types {{{
    augroup filetypes
        autocmd BufNewFile,BufRead *.rss setfiletype xml
        autocmd BufRead,BufNewFile *.less,*.css setfiletype css
        autocmd BufRead,BufNewFile *.haml set ft=haml
        autocmd BufRead,BufNewFile *.go set ft=go
        autocmd BufRead,BufNewFile *.gss set ft=css
    augroup END " }}}

    " Only show cursorline in the current window and in normal mode {{{
    augroup cline
        au!
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline
    augroup END " }}}

    " Neovim-specific {{{
    if has("nvim")
        " Nothing here, yet
    endif " }}}
endif
" --------------------------------------------------------------------------}}}

" FUNCTIONS ----------------------------------------------------------------{{{

" Cycle through spell check languages --------------------------------------{{{
" (remember: ]s, [s, z=, zg)
let g:myLang = 1
let g:myLangList = ['nospell', 'en_gb', 'sv']
function! SpellCheck()
  " loop through languages:
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
" --------------------------------------------------------------------------}}}

" Kill PDF viewer (for vimtex) -------------------------------------------{{{
function! KillViewer()
    call system('killall mupdf 2> /dev/null')
endfunction
" --------------------------------------------------------------------------}}}

" Set spell check colors (for colorschemes without sensible defaults) ----{{{
function! SetSpellColors()
    hi SpellBad cterm=underline ctermfg=red ctermbg=NONE
    hi SpellLocal cterm=underline ctermfg=blue ctermbg=NONE
endfunction
" --------------------------------------------------------------------------}}}

" At day, use light color - other times, use dark color --------------------{{{
" (to change manually, see mappings <leader>td and <leader>tl)
function! SetColor(which)
    let l:color_options = []
    if a:which == 'dark'
        let l:color = g:dark_color
        if exists('g:dark_color_options')
            let l:color_options = g:dark_color_options
        endif
    elseif a:which == 'light'
        let l:color = g:light_color
        if exists('g:light_color_options')
            let l:color_options = g:light_color_options
        endif
    endif
    execute 'colorscheme ' . l:color
    for option in l:color_options
        execute option
    endfor

    call SetSpellColors()
endfunction
function! AutoSetColor()
    let l:hour = system('date +%H')
    if system('which sun') =~ 'not found' " sun script not found
        if (l:hour >= 6 && l:hour <= 18) " default hours (spring)
            call SetColor('light')
        else
            call SetColor('dark')
        endif
    else " sun script found
        if (l:hour >= system('sun rise') && l:hour <= system('sun set'))
            call SetColor('light')
        else
            call SetColor('dark')
        endif
    end
endfunction
call AutoSetColor()
" --------------------------------------------------------------------------}}}

" Create pretty fold on current line (doesn't work everywhere yet) -------{{{
function! CreateFold(...)
    let l:close =  a:0 >= 1 ? a:1 : 0 " a:0 = no of arguments, a:1 = 1st argument
    let l:indent = a:0 >= 2 ? a:2 : -1
    let l:line1 = a:0 >= 3 ? a:3 : -1
    let l:line2 = a:0 >= 4 ? a:4 : -1

    if l:line1 > 0
        call cursor(l:line1, 0)
    endif

    let l:lineno = getpos('.')[1] " line number

    if l:indent == -1
        let l:indent = substitute(getline('.'), '^\(\s*\)\(.\{-}\)\s*$', '\1', '')
    endif

    if l:close == 1
        " {{{
        call setline(l:lineno, l:indent . '----------------------------------------------------------------------------}}}')
    else
        call setline(l:lineno, l:indent . '----------------------------------------------------------------------------{{{')
        " }}}
    end

    call NERDComment('n', 'comment') " comment the line properly

    " Remove -'s until length of line (without whitespace) <= textwidth:
    while strlen(substitute(getline('.'), '^\s*\(.\{-}\)\s*$', '\1', '')) > &textwidth
        normal! $F-x
    endwhile


    if l:close == 0
        " Create closing fold marker below:
        if l:line2 > -1
            call cursor(l:line2, 0)
        endif
        normal! o
        call CreateFold(1, l:indent)
        if l:line1 > -1
            call cursor(l:line1, 0)
        else
            normal! k
        endif

        " Go to first - and let user enter fold title:
        normal! ^f-
        startgreplace
    endif
endfunction
" --------------------------------------------------------------------------}}}

" Wrap selection in pretty fold (using CreateFold())------------------------{{{
function! WrapInFold()
    let l:line1 = line("'<")
    let l:line2 = line("'>")

    let l:lines = line("'>") - line("'<") + 1 " no of lines selected

    call cursor(line("'<"), 0)
    normal! O
    call CreateFold(0, -1, line("'<") - 1, line("'>"))
endfunction
" --------------------------------------------------------------------------}}}

" --------------------------------------------------------------------------}}}

" MAPPINGS -----------------------------------------------------------------{{{

noremap ; :

nnoremap <silent> <leader>r :so $MYVIMRC<CR>:noh<CR>
" ^ reload vimrc (for some reason, adding <C-U> has the side effect of moving
" the cursor one character forward after using this command...?)
nnoremap <silent> <leader>l :<C-U>set list!<CR>
" ^ display list invisible characters
nnoremap <silent> <leader><space> :<C-U>noh<CR>
" ^ unhighlight matches
nnoremap <leader>w gq}
" ^ wrap paragraph
noremap <leader>m ^d$k$a <Esc>pjddk$
" ^ append previous line with current line
inoremap <CR> <Esc>
" ^ use <CR> as <Esc> (use <C>-<CR> to create new line in insert mode)

" Switch color schemes (light/dark):
nnoremap <silent> <leader>tl :<C-U>call SetColor('light')<CR>
nnoremap <silent> <leader>td :<C-U>call SetColor('dark')<CR>

" Spell check:
noremap <silent> <F2> :<C-U>call SpellCheck()<CR>

" Tabs:
nnoremap <silent> <leader>. :<C-U>tabprevious<CR>
nnoremap <silent> <leader>/ :<C-U>tabnext<CR>

" Folds --------------------------------------------------------------------{{{
noremap <leader>O zR
noremap <leader>C zM

if has('autocmd') " for now, only use for VimL (buggy elsewhere)
    au FileType vim noremap <leader>f :<C-U>call CreateFold()<CR>
    au FileType vim vnoremap <leader>f :<C-U>call WrapInFold()<CR>
endif
" --------------------------------------------------------------------------}}}

" Splits -------------------------------------------------------------------{{{
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-l> <C-W>l
map <leader>0 <C-W>l500<C-W>>
" ^ hides split

" vsplit:
nnoremap - <C-W><
nnoremap = <C-W>>
" (for (h)split, see hsplit-resize submode)
" --------------------------------------------------------------------------}}}

" Swedish letters {{{
inoremap <localleader>[ å
inoremap <localleader>' ä
inoremap <localleader>; ö

inoremap <localleader>{ Å
inoremap <localleader>" Ä
inoremap <localleader>: Ö

" In case one accidentally presses shift with localleader (\):
inoremap \|{ Å
inoremap \|" Ä
inoremap \|: Ö
" NOTE: | has to be escaped in the mapping -> \|
" NOTE: remember to change this binding if localleader is changed
" }}}

" paste/nopaste {{{
if !has('nvim') " not needed in neovim (AFAIK)
    nnoremap <leader>p :set paste<cr>
    inoremap <leader>p <Esc>:set paste<cr>i
    nnoremap <leader>pp :set nopaste<cr>
endif
" }}}

" --------------------------------------------------------------------------}}}

" SUBMODES -----------------------------------------------------------------{{{

" hsplit-resize ------------------------------------------------------------{{{
" (h)split:
call submode#enter_with('hsplit-resize', 'n', '', '<leader>-', '<C-W>-')
call submode#enter_with('hsplit-resize', 'n', '', '<leader>=', '<C-W>+')
call submode#map('hsplit-resize', 'n', '', '-', '<C-W>-')
call submode#map('hsplit-resize', 'n', '', '=', '<C-W>+')
" --------------------------------------------------------------------------}}}

" --------------------------------------------------------------------------}}}
