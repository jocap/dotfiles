" ========================
" VIMRC by John Ankarström

" - LICENSE --------------
" Do  Whatever   You  Want
" With It  (Hell,  You Can
" Eat  It   If  You  Want)
" ========================

" BUNDLES
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() " (http://vimcasts.org/e/27)

set encoding=utf-8
set cpo+=J " For double spacing after periods
set foldmethod=marker " {{{}}} " folding
let mapleader = ","

" AUTOCMD "

if has("autocmd")
    filetype on

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

    autocmd FileType python set ft=python.django " For SnipMate
    autocmd FileType html set ft=htmldjango.html " For SnipMate
endif

" FUNCTIONS "

" - Enables folding by indent
set foldmethod=syntax
function! FDMi()
        set foldmethod=indent
endfunc
function! FDMs()
        set foldmethod=syntax
endfunc
nnoremap <C-k> :call FDMi()<cr>
nnoremap <C-l> :call FDMs()<cr>

" - Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <C-S-O> :call <SID>SynStack()<CR>

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

" PLUGINS "

" - ctrp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" - markdown-preview.vim
set runtimepath^=~/.vim/bundle/markdown-preview.vim

" COMMANDS & MAPPINGS

" - Convenient alternatives to ^ and $
nmap - ^
nmap + $

" - :e on steroids, I hear
command! -nargs=* E e %:p:h/<args>

" <LEADER> SHORTCUTS "

nmap <leader>l :set list!<cr>
