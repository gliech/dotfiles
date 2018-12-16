"""""""""""""""""""""""""""""""""""""""""""""""""
" FROM https://www.fullstackpython.com/vim.html "
"""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax highlighting
syntax enable

" set tab characters to be 4 spaces long, visually
set tabstop=4

" indent when moving to the next line while writing code
set autoindent

" type a number of spaces when you press the tab key
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
" set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
" let python_highlight_all = 1


""""""""""""""""""""""
" FROM archlinux.vim "
""""""""""""""""""""""

" use vim defaults instead of 100% vi compatibility
"set nocompatible

" always show the status line at the bottom of the terminal
set ruler

" make deleting things in insert mode not retarded
set backspace=indent,eol,start


""""""""""""""""""""""""""
" MY OWN CONFIGS -Gregor "
""""""""""""""""""""""""""

" show line numbers. good for coding, bad when you want to copy text from vim
set number

set softtabstop=4

" let vim decide if i want to go an indent level deeper depending on the type
" of file i'm writing in and what i have written in the last line
filetype indent on

" Add a set of commands that will make the 80th column of a document visible
highlight ColorColumn ctermbg=244 guibg=lightgrey
command Col let &colorcolumn=join(range(81,999),",")
command NoCol set colorcolumn=

" Usable method for highlighting trailing white spaces from
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html


autocmd BufReadPost * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red
