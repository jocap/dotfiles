set encoding=utf-8

set cpo+=J " For double spacing after periods

if &term =~ "xterm"
    " don't do this if you have 8-color xterms
    set term=xterm-16color
endif

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" (http://vimcasts.org/e/27

let mapleader = ","

if has("autocmd")
    filetype on
    autocmd FileType python set ft=python.django " For SnipMate
    autocmd FileType html set ft=htmldjango.html " For SnipMate
endif

" Activate folding:
set foldmethod=marker " {{{}}}

" Wrap command:
command! -nargs=* Wrap set wrap linebreak nolist showbreak=â¦

command! -nargs=* E e %:p:h/<args>

if executable("par")
    command! -nargs=* Par set formatprg=par\ -w50\ -j\ -q
endif

if has("autocmd")
    if executable("par")
        autocmd FileType markdown,textile,mail Par()
    endif
    autocmd FileType markdown,textile imap <C-S-Z> <Esc>gqip<S-A>
endif

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Shortcut to rapidly toggle `set list`:
nmap <leader>l :set list!<CR>
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
" ^ and $
nmap - ^
nmap + $

" Reveal the highlight 'name'
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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

if has("autocmd")

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml
    " Highlight .less files as CSS
    autocmd BufRead,BufNewFile *.less,*.css setfiletype css

    autocmd BufRead,BufNewFile *.haml set ft=haml
endif

" Enables folding by indent
set foldmethod=syntax
function! FDMi()
        set foldmethod=indent
endfunc
function! FDMs()
        set foldmethod=syntax
endfunc
nnoremap <C-k> :call FDMi()<cr>
nnoremap <C-l> :call FDMs()<cr>
