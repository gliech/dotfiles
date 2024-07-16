call plug#begin()
" Display if updates for plugins are available
Plug 'semanser/vim-outdated-plugins'
" Show trailing whitespaces (this could also easily be achieved by settings,
" but the plugin is very neat)
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'sirtaj/vim-openscad'
Plug 'AndrewRadev/bufferize.vim'
Plug 'airblade/vim-gitgutter'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
call plug#end()

" Add a set of commands that will make the 80th column of a document visible
highlight ColorColumn ctermbg=244 guibg=lightgrey
command Col let &colorcolumn=join(range(81,100),",")
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

" Tweak the neovim popup-style(pum) wildmenu for file selection. Slightly
" alter the behaviour when you press the tab key and rotate the axis of the
" arrow keys. https://vi.stackexchange.com/a/22628
" FIXME: Pressing left during file selection moves up 2 levels in the dir
" tree. This is a problem with the wildmenu file selector in general.
set wildmode=longest:full,full
set wildcharm=<C-z>
cnoremap <expr> <down> wildmenumode() ? "\<C-n>" : "\<down>"
cnoremap <expr> <up> wildmenumode() ? "\<C-p>" : "\<up>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-z>" : "\<right>"

" Rebind Redo to U
nnoremap U <C-r>

" Classic
set number
set nofoldenable

" If this is not set, neovim will hide tabs instead of closing them, resulting
" in errors if you close a file as tab in one vim instance and subsecuently
" try to open it in another instance. I have not checked if this has other
" side effects.
set nohidden

" Yaml Indent
autocmd BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Treat .hcl files like terraform files (used by hashivim/vim-terraform)
autocmd BufNewFile,BufReadPost *.hcl set filetype=terraform

" Overwrite airblade/vim-gitgutter highlight colors.
" https://vi.stackexchange.com/questions/10897/how-do-i-customize-vimdiff-colors
hi DiffAdd      gui=none    guifg=NONE          guibg=#bada9f
hi DiffChange   gui=none    guifg=NONE          guibg=#e5d5ac
hi DiffDelete   gui=bold    guifg=#ff8080       guibg=#ffb0b0
hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2
