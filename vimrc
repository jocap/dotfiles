call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" (http://vimcasts.org/e/27

let mapleader = ","

if has("autocmd")
    autocmd FileType python set ft=python.django " For SnipMate
    autocmd FileType html set ft=htmldjango.html " For SnipMate
endif

" Activate folding:
set foldmethod=marker " {{{}}}

" Wrap command:
command! -nargs=* Wrap set wrap linebreak nolist showbreak=…

command! -nargs=* E e %:p:h/<args>

if executable("par")
    command! -nargs=* Par set formatprg=par\ -w50\ -j\ -q
endif

if has("autocmd")
    filetype on
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

" Reveal the highlight 'name'
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
