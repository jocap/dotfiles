" =============================================================================
"                           VIMRC: by John Ankarström
" =============================================================================

" PLUGINS =================================================================={{{

" Loading ------------------------------------------------------------------{{{
call plug#begin('~/.vim/plugins')
" Extensions:
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'kana/vim-submode' | Plug '/home/john/.vim/dev/plugins/jumpinline.vim'
" Tools:
Plug 'junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-obsession' " session management (:Obsess <filename>)
Plug 'junegunn/vader.vim', { 'for': 'vader' } " tests
Plug 'chrisbra/NrrwRgn'
Plug 'wesQ3/vim-windowswap'
Plug 'KabbAmine/vCoolor.vim', { 'for': 'css' } " color selector
Plug 'jocap/vim-interestingwords' " <leader>k, <leader>K
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
" Modes:
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'ap/vim-css-color', { 'for': 'css' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'html'] }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" Neovim:
if has('nvim')
    Plug 'jocap/vim-snippets' | Plug 'SirVer/ultisnips'
endif
call plug#end()

" --------------------------------------------------------------------------}}}

" Configuration ------------------------------------------------------------{{{

" NERDtree {{{
let g:NERDTreeWinSize = 30
nnoremap <silent> <C-f> :<C-U>NERDTreeToggle<CR><C-l>
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

" fzf ----------------------------------------------------------------------{{{

" Mappings:

nnoremap <silent> <space><space> :<C-U>Files<CR><C-\><C-N>:<C-U>setlocal statusline=%#Normal#<CR>i
nnoremap <silent> <space>b :<C-U>Buffers<CR><C-\><C-N>:<C-U>setlocal statusline=%#Normal#<CR>i
nnoremap <silent> <space>l :<C-U>BLines<CR><C-\><C-N>:<C-U>setlocal statusline=%#Normal#<CR>i
nnoremap <silent> <space>h :<C-U>History<CR><C-\><C-N>:<C-U>setlocal statusline=%#Normal#<CR>i
nnoremap <silent> <space>c :<C-U>call fzf#vim#command_history({'right': '40'})<CR><C-\><C-N>:<C-U>setlocal statusline=%#Normal#<CR>i
nnoremap <silent> <space>, :<C-U>call fzf#vim#search_history({'right': '40'})<CR><C-\><C-N>:<C-U>setlocal statusline=%#Normal#<CR>i

" Actions:

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit' }

" Completion:

let g:custom_fzf_completion_layout = {
    \ 'options': '--multi --reverse',
    \ 'right': 19 }

inoremap <expr> <c-x><c-k> fzf#complete(extend(
\ { 'source': 'cat /usr/share/dict/words' }, g:custom_fzf_completion_layout))
inoremap <expr> <c-x><c-s> fzf#complete(extend(
\ { 'source': 'cat /usr/share/dict/svenska' }, g:custom_fzf_completion_layout))

imap <c-x><c-l> <plug>(fzf-complete-line)

" --------------------------------------------------------------------------}}}

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit='vertical'
nnoremap <silent> <leader>s :<C-U>call UltiSnips#ListSnippets()<CR>
" }}}

" submode {{{
let g:submode_keep_leaving_key = 1 " leave submode by pressing any other key
" }}}

" jumpinline.vim {{{
" - default configuration
" }}}

" vCoolor (Alt-R/V/W) {{{
let g:vcoolor_lowercase = 1 " lowercase hex colors
" }}}

" tagbar {{{
nnoremap <silent> <space>t :<C-U>TagbarToggle<CR>
" }}}

" NrrwRgn (<leader>nr, :NRP -> :NRM) {{{
let g:nrrw_rgn_vert = 1 " use vertical split
let g:nrrw_rgn_wdth = 80
let g:nrrw_rgn_hl = 'WildMenu' " default: WildMenu
let g:nrrw_topbot_leftright = 'botright' " window appears on bottom/right
" }}}

" WindowSwap {{{
let g:windowswap_map_keys = 0 " prevent default bindings
nnoremap <silent> <space>ww :call WindowSwap#EasyWindowSwap()<CR>
" }}}

" lightline.vim {{{
let g:lightline = { 'colorscheme': 'jellybeans' }
" }}}

" --------------------------------------------------------------------------}}}

" ==========================================================================}}}

" BASIC OPTIONS ============================================================{{{
if &compatible | set nocompatible | endif
set encoding=utf-8
set undofile          " enable persistent undo
set backup            " enable backups
set nomodeline        " disable parsing of :set command at BOF and EOF
set showcmd           " display command letters pressed in lower-right corner
set laststatus=2      " always show status bar
set synmaxcol=800     " don't highlight lines over 800 characters
set scrolloff=5       " keep margin of 5 lines minimum above/below cursor
set mouse=a           " mouse mode
set foldmethod=marker " use markers to fold (three curly braces)
set ruler             " show line number, position in line, etc.
set hidden            " allow buffers to be hidden
set nojoinspaces      " disable double-spacing sentences when using shift-j
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
set undodir=~/.vim/tmp/undo/        " undo files
set backupdir=~/.vim/tmp/backup/    " backups
set directory=~/.vim/tmp/swap/      " swap files
set viminfo+='1000,n~/.vim/.viminfo " .viminfo

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

" Indentation and formatting {{{
set ts=4 sts=4 sw=4 expandtab
set smartindent
inoremap # X<C-H>#
" ^ prevent smartindent from de-indenting lines starting with #
set autoindent
set nowrap
set textwidth=79
set formatoptions=cqn2j " auto-wrap comments,
                        " allow gq,
                        " recognize numbers lists,
                        " use 2nd line indent for whole paragraph,
                        " join comments in a better way
" Note: there are more format options under autocmd
" }}}

" ==========================================================================}}}

" GRAPHICAL OPTIONS ========================================================{{{
syntax on
filetype plugin indent on
set cursorline

set colorcolumn=80
let &colorcolumn=join(range(80,999),",")

" Colorscheme setup --------------------------------------------------------{{{
" The following could be done with autocmd, but less flexibly.

let s:dark_color = 'jellybeans'
function! s:dark_color_options()
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=237
    hi ColorColumn ctermbg=234
    hi MatchParen cterm=bold ctermbg=NONE ctermfg=226
    hi WildMenu ctermbg=17 ctermfg=3
    if s:terminal_color() == 'solarized-light'
        highlight NbSp ctermfg=238
    endif
    call s:update_lightline_theme('jellybeans')
endfunction

let s:light_color = 'calmar256-light'
function! s:light_color_options()
    hi ColorColumn ctermbg=229
    hi MatchParen cterm=bold ctermbg=223 ctermfg=88
    if s:terminal_color() == 'solarized-light'
        highlight NbSp ctermfg=253 ctermbg=230
    endif
    call s:update_lightline_theme('solarized')
endfunction

let s:alt_color = 'solarized-light'
function! s:alt_color_options()
    if s:terminal_color() == 'solarized-light'
        highlight NbSp ctermfg=253 ctermbg=255
    endif
    call s:update_lightline_theme('solarized')
endfunction

" Options for all colorschemes:
function! s:color_options()
    hi SpellBad cterm=underline ctermfg=1 ctermbg=NONE
    hi SpellLocal cterm=underline ctermfg=6 ctermbg=NONE

    " Default NbSp highlighting:
    if s:terminal_color() != 'solarized-light'
        highlight NbSp ctermfg=8
    endif
endfunction
" --------------------------------------------------------------------------}}}

" ==========================================================================}}}

" AUTOCMD =================================================================={{{
if has("autocmd")
    " Remember last location in file:
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif

    " Format options:
    autocmd FileType * setlocal fo-=r fo-=o
    " ^ don't add new comment on new line after comment

    " Tabs (spaces):
    autocmd Filetype python setlocal ts=2 sts=2 sw=2

    " vimtex:
    autocmd User VimtexEventCompileStopped,VimtexEventQuit call KillViewer()
    " ^ kill pdf viewer when compilation stops or latex file is closed

    " Markdown files:
    augroup markdown
        autocmd FileType markdown setlocal fo+=t
        autocmd FileType markdown match NbSp /&nbsp;/
        autocmd BufWinEnter markdown match NbSp /&nbsp;/
    augroup END

    " Setup filetypes {{{
    augroup filetypes
        autocmd BufNewFile,BufRead *.rss setfiletype xml
        autocmd BufNewFile,BufRead *.gss set ft=css
    augroup END " }}}

    " Only show cursorline in the current window and in normal mode {{{
    augroup cline
        autocmd!
        " ^ remove current autocmds from group
        autocmd WinLeave,InsertEnter * set nocursorline
        autocmd WinEnter,InsertLeave * set cursorline
    augroup END " }}}

    " Neovim-specific {{{
    if has("nvim")
        " Nothing here, yet
    endif " }}}
endif
" ==========================================================================}}}

" FUNCTIONS ================================================================{{{

" Cycle through spell check languages --------------------------------------{{{
" (remember: ]s, [s, z=, zg)
let g:myLang = 1
let g:myLangList = ['nospell', 'en_gb', 'sv']
function! SpellCheck()
  " loop through languages:
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 2 | let &spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
" ==========================================================================}}}

" Kill PDF viewer (for vimtex) -------------------------------------------{{{
function! KillViewer()
    call system('killall mupdf 2> /dev/null')
endfunction
" --------------------------------------------------------------------------}}}

" Returns what colorscheme terminal is using (if available) ----------------{{{
" (Created very much for my own personal setup)
function! s:terminal_color()
    if filereadable(expand('~/.tmp/xfce-color'))
        return readfile(expand('~/.tmp/xfce-color'))[0]
    endif
endfunction
" --------------------------------------------------------------------------}}}

" Update lightline.vim theme -----------------------------------------------{{{
function! s:update_lightline_theme(theme)
    let g:lightline.colorscheme = a:theme
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
" --------------------------------------------------------------------------}}}

" At day, use light color - other times, use dark color --------------------{{{
" (to change manually, see mappings <leader>td and <leader>tl)
function! SetColor(which)
    if a:which == 'dark'
        execute 'colorscheme ' . s:dark_color
        if exists('*s:dark_color_options')
            call s:dark_color_options()
        endif
    elseif a:which == 'light'
        execute 'colorscheme ' . s:light_color
        if exists('*s:light_color_options')
            call s:light_color_options()
        endif
    elseif a:which == 'alt'
        execute 'colorscheme ' . s:alt_color
        if exists('*s:alt_color_options')
            call s:alt_color_options()
        endif
    endif

    if exists('*s:color_options')
        call s:color_options()
    endif

    " Refresh buffers:
"    silent bufdo e!
endfunction
function! AutoSetColor()
    let hour = system('date +%H.%M')
    if system('which sun') =~ 'not found' " sun script not found
        if (hour >= 6.00 && hour < 18.00) " default hours (spring)
            call SetColor('light')
        else
            call SetColor('dark')
        endif
    else " sun script found
        if (hour >= str2nr(system('sun rise'))
        \ && hour < str2nr(system('sun set')))
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
    let close =  a:0 >= 1 ? a:1 : 0 " a:0 = no of arguments, a:1 = 1st argument
    let indent = a:0 >= 2 ? a:2 : -1
    let line1 = a:0 >= 3 ? a:3 : -1
    let line2 = a:0 >= 4 ? a:4 : -1

    if line1 > 0
        call cursor(line1, 0)
    endif

    let lineno = getpos('.')[1] " line number

    if indent == -1
        let indent = substitute(getline('.'), '^\(\s*\)\(.\{-}\)\s*$', '\1', '')
    endif

    if close == 1
        " {{{
        call setline(lineno, indent . '----------------------------------------------------------------------------}}}')
    else
        call setline(lineno, indent . '----------------------------------------------------------------------------{{{')
        " }}}
    end
    
    " Comment out line (using vim-commentary):
    normal gcc

    " Remove -'s until length of line (without whitespace) <= textwidth:
    while strlen(substitute(getline('.'), '^\s*\(.\{-}\)\s*$', '\1', '')) > &textwidth
        normal! $F-x
    endwhile


    if close == 0
        " Create closing fold marker below:
        if line2 > -1
            call cursor(line2, 0)
        endif
        normal! o
        call CreateFold(1, indent)
        if line1 > -1
            call cursor(line1, 0)
        else
            normal! k
        endif

        " Go to first - and let user enter fold title:
        normal! ^f-
        startgreplace
    endif
endfunction
" --------------------------------------------------------------------------}}}

" Wrap selection in pretty fold (using CreateFold()) -----------------------{{{
function! WrapInFold()
    let line1 = line("'<")
    let line2 = line("'>")

    let lines = line("'>") - line("'<") + 1 " no of lines selected

    call cursor(line("'<"), 0)
    normal! O
    call CreateFold(0, -1, line("'<") - 1, line("'>"))
endfunction
" --------------------------------------------------------------------------}}}

" ==========================================================================}}}

" MAPPINGS & COMMANDS ======================================================{{{

noremap ; :
noremap ' ;
" ^ set ' to default ; (repeat) - use ` to go to mark.

nnoremap <silent> <leader>r :so $MYVIMRC<CR>:noh<CR>
" ^ reload vimrc (for some reason, adding <C-U> has the side effect of moving
" the cursor one character forward after using this command...?)
nnoremap <silent> <leader>l :<C-U>set list!<CR>
" ^ display list invisible characters
nnoremap <silent> <leader><space> :<C-U>noh<CR>
" ^ toggle highlighting of search matches
nnoremap <leader>w gq}
" ^ wrap till end of paragraph
inoremap <CR> <Esc>
" ^ use <CR> as <Esc> (use <C>-<CR> to create new line in insert mode)
command! Vrc tabnew ~/.vim/vimrc
" ^ edit vimrc in new tab
nnoremap <silent> <F12> :<C-U>syntax sync fromstart<CR>
" ^ fix syntax highlighting on the fly

" Switch color schemes (light/dark):
nnoremap <silent> <leader>tl :<C-U>call SetColor('light')<CR>
nnoremap <silent> <leader>td :<C-U>call SetColor('dark')<CR>
nnoremap <silent> <leader>ta :<C-U>call SetColor('alt')<CR>

" Spell check:
noremap <silent> <F2> :<C-U>call SpellCheck()<CR>

" Tabs:
nnoremap <silent> <leader>. :<C-U>tabprevious<CR>
nnoremap <silent> <leader>/ :<C-U>tabnext<CR>

" Folds ===================================================================={{{
nnoremap <leader>O zR
nnoremap <leader>C zM

if has('autocmd') " for now, only use for VimL (buggy elsewhere)
    au FileType vim noremap <leader>f :<C-U>call CreateFold()<CR>
    au FileType vim vnoremap <leader>f :<C-U>call WrapInFold()<CR>
endif
" ==========================================================================}}}

" Splits ==================================================================={{{
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-l> <C-W>l
map <leader>0 <C-W>l500<C-W>>
" ^ hides split

" vsplit:
nnoremap - <C-W><
nnoremap = <C-W>>
noremap \| =
" ^ Make | auto-indent instead of =, seeing as how we've replaced =
" (for (h)split, see hsplit=resize submode)
" ==========================================================================}}}

" Swedish letters {{{
inoremap =e é
inoremap <[ å
inoremap <' ä
inoremap <; ö

inoremap <{ Å
inoremap <" Ä
inoremap <: Ö

" In case one accidentally presses shift with <
inoremap >{ Å
inoremap >" Ä
inoremap >: Ö
" }}}

" paste/nopaste {{{
if !has('nvim') " not needed in neovim (AFAIK)
    nnoremap <leader>p :set paste<cr>
    inoremap <leader>p <Esc>:set paste<cr>i
    nnoremap <leader>pp :set nopaste<cr>
endif
" }}}

" ==========================================================================}}}

" SUBMODES ================================================================={{{

" hsplit-resize ------------------------------------------------------------{{{
" (h)split:
call submode#enter_with('hsplit-resize', 'n', '', '<leader>-', '<C-W>-')
call submode#enter_with('hsplit-resize', 'n', '', '<leader>=', '<C-W>+')
call submode#map('hsplit-resize', 'n', '', '-', '<C-W>-')
call submode#map('hsplit-resize', 'n', '', '=', '<C-W>+')
" --------------------------------------------------------------------------}}}

" ==========================================================================}}}
