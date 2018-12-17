call plug#begin()
" Display if updates for plugins are available
Plug 'semanser/vim-outdated-plugins'
" Show trailing whitespaces (this could also easaly be achieved by settings
Plug 'ntpeters/vim-better-whitespace'
call plug#end()

" Add a set of commands that will make the 80th column of a document visible
highlight ColorColumn ctermbg=244 guibg=lightgrey
command Col let &colorcolumn=join(range(81,999),",")
command NoCol set colorcolumn=
Col

" Disable line wrapping and use some Unicode characters to signify overflow
" instead. This might obviously cause problems. Also make tabs and
" non-breaking spaces visible. Tab visibility may be toggled using ShowTabs
" and HideTabs.
set nowrap
set list
command ShowTabs let &l:listchars = 'tab:╾─,extends:┃,precedes:┃,nbsp:␣'
command HideTabs let &l:listchars = 'tab:  ,extends:┃,precedes:┃,nbsp:␣'
ShowTabs
set sidescroll=1
set sidescrolloff=8

" Classic
set number

