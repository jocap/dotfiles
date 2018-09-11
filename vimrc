syntax on
set mouse=a
set number ruler nowrap
set textwidth=80
set expandtab softtabstop=4 shiftwidth=4
set formatoptions=tcq2
set splitright splitbelow

silent !mkdir -p ~/.vim/undo
set undodir=~/.vim/undo
set undofile

inoremap <CR> <Esc>
vnoremap <CR> <Esc>

nnoremap <leader>n :call search(@")<CR>
nnoremap <leader>N :call search(@", "b")<CR>

if !empty(glob($HOME."/.vim/plugin/fzf.vim"))
    source ~/.vim/plugin/fzf.vim
    nnoremap <leader>t :FZF<CR>
endif
