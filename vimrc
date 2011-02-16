call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" (http://vimcasts.org/e/27

let mapleader = ","

" Activate folding:
set foldmethod=marker " {{{}}}

" Wrap command:
command! -nargs=* Wrap set wrap linebreak nolist showbreak=…

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Shortcut to rapidly toggle `set list`:
nmap <leader>l :set list!<CR>
