local Plug = vim.fn['plug#']
local function key2nr(str)
  return vim.fn.char2nr(vim.keycode(str))
end

vim.call('plug#begin')
-- Display if updates for plugins are available
Plug('semanser/vim-outdated-plugins')
-- Show trailing whitespaces (this could also easily be achieved by settings,
-- but the plugin is very neat)
Plug('ntpeters/vim-better-whitespace')
Plug('vim-airline/vim-airline')
Plug('w0rp/ale')
Plug('sirtaj/vim-openscad')
Plug('AndrewRadev/bufferize.vim')
Plug('airblade/vim-gitgutter')
Plug('hashivim/vim-terraform')
Plug('tpope/vim-fugitive')
Plug('tpope/vim-rhubarb')
vim.call('plug#end')


-- Explicitely set legacy colorscheme to overwrite the new neovim default
-- colorscheme until I find the time to configure colors properly
vim.cmd.colorscheme('vim')
vim.opt.termguicolors = false
-- this fixes the airline statusline colors inverting when using the default
-- terminal colors with the vim colorscheme (and others)
vim.cmd.highlight({"StatusLine", "gui=None", "cterm=None"})
vim.cmd.highlight({"StatusLineNC", "gui=None", "cterm=None"})
vim.cmd.highlight({"StatusLineTerm", "gui=None", "cterm=None"})
vim.cmd.highlight({"StatusLineTermNC", "gui=None", "cterm=None"})

-- vim airline config
vim.g.airline_powerline_fonts = 1


-- Add a set of commands that will make the 80th column of a document visible
vim.cmd.highlight({"ColorColumn", "guibg=DarkGray", "ctermbg=DarkGray"})
vim.api.nvim_create_user_command('Col',
  function() vim.opt.colorcolumn = vim.fn.range(81,100) end, {})
vim.api.nvim_create_user_command('NoCol',
  function() vim.opt.colorcolumn = nil end, {})
vim.cmd.Col()

-- Disable line wrapping and use some Unicode characters to signify overflow
-- instead. This might obviously cause problems. Also make tabs and
-- non-breaking spaces visible. Tab visibility may be toggled using ShowTabs
-- and HideTabs.
vim.opt.wrap = false
vim.opt.list = true
vim.opt.showbreak = '❱'
vim.opt.listchars = {tab = '╾─', extends = '❱', precedes = '❰', nbsp = '␣'}
vim.api.nvim_create_user_command('ShowTabs',
  function() vim.opt.listchars:append({tab = '╾─'}) end, {})
vim.api.nvim_create_user_command('HideTabs',
  function() vim.opt.listchars:append({tab = '  '}) end, {})
vim.cmd.ShowTabs()
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 2


-- Tweak the neovim popup-style(pum) wildmenu for file selection. Slightly
-- alter the behaviour when you press the tab key and rotate the axis of the
-- arrow keys. https://vi.stackexchange.com/a/22628
-- FIXME: Pressing left during file selection moves up 2 levels in the dir
-- tree. This is a problem with the wildmenu file selector in general.

vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.wildcharm = key2nr('<C-z>')
vim.keymap.set('c', '<down>', function()
  if vim.fn.wildmenumode()==1 then return '<C-n>' end
  return '<down>' end, {expr = true})
vim.keymap.set('c', '<up>', function()
  if vim.fn.wildmenumode()==1 then return '<C-p>' end
  return '<up>' end, {expr = true})
vim.keymap.set('c', '<left>', function()
  if vim.fn.wildmenumode()==1 then return '<up>' end
  return '<left>' end, {expr = true})
-- This does not work for some reason but the equivalent vimscript code does,
-- and I do not care enough to find out why they behave differently.
-- vim.keymap.set('c', '<right>', function()
--   if vim.fn.wildmenumode()==1 then return '<bs><C-z>' end
--   return '<right>' end, {expr = true})
vim.cmd([[cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-z>" : "\<right>"]])

-- Rebind Redo to U
vim.keymap.set('n', 'U', '<C-r>')

-- The classics
vim.opt.number = true
vim.opt.foldenable = false

-- If this is not set, neovim will hide tabs instead of closing them, resulting
-- in errors if you close a file as tab in one vim instance and subsecuently
-- try to open it in another instance. I have not checked if this has other
-- side effects.
vim.opt.hidden = false

-- Yaml Indent
vim.api.nvim_create_autocmd({'BufNewFile', 'BufReadPost'}, {
  pattern = {'*.yaml', '*.yml'},
  callback = function()
    vim.opt.filetype = 'yaml'
    vim.opt.foldmethod = 'indent'
  end
})
vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = {'yaml'},
  callback = function()
    vim.opt_local.ts = 2
    vim.opt_local.sts = 2
    vim.opt_local.sw = 2
    vim.opt_local.expandtab = true
    vim.opt_local.indentkeys:remove({'0#', '<:>'})
  end
})
-- vim.cmd([[autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>]])

-- Treat .hcl files like terraform files (used by hashivim/vim-terraform)
vim.api.nvim_create_autocmd({'BufNewFile', 'BufReadPost'}, {
  pattern = '*.hcl',
  callback = function() vim.opt.filetype = 'terraform' end
})

-- Overwrite airblade/vim-gitgutter highlight colors.
-- https://vi.stackexchange.com/questions/10897/how-do-i-customize-vimdiff-colors
vim.cmd.highlight({"DiffAdd", "gui=none", "guifg=NONE", "guibg=#bada9f"})
vim.cmd.highlight({"DiffChange", "gui=none", "guifg=NONE", "guibg=#e5d5ac"})
vim.cmd.highlight({"DiffDelete", "gui=bold", "guifg=#ff8080", "guibg=#ffb0b0"})
vim.cmd.highlight({"DiffText", "gui=none", "guifg=NONE", "guibg=#8cbee2"})
