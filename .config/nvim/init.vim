call plug#begin()
" Display if updates for plugins are available
Plug 'semanser/vim-outdated-plugins'
" Show trailing whitespaces (this could also easily be achieved by settings,
" but the plugin is very neat)
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
set showbreak=❱
set listchars=tab:╾─,extends:❱,precedes:❰,nbsp:␣
command ShowTabs set listchars-=tab:\ \ 
command HideTabs set listchars+=tab:\ \ 
set sidescroll=1
set sidescrolloff=8
set scrolloff=2

" Classic
set number

