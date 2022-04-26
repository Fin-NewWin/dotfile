local opt = vim.opt
local g = vim.g

-- Need this for everything
vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
vim.go.t_8b = "[[48;2;%lu;%lu;%lum"
opt.termguicolors = true

-- makes pum menu smaller
opt.pumheight = 10

-- show cursor position
opt.ruler = true

-- Line Number
opt.number = true

-- Indent
opt.linebreak = true
opt.breakindent = true
vim.api.nvim_create_autocmd('FileType', { command = 'setlocal ts=4 sts=4 sw=4 expandtab' })

-- Files
opt.backup = false
opt.swapfile = false
opt.undofile = true

-- Format
opt.fileformat = 'unix'
opt.encoding = 'UTF-8'

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Cursor
opt.cursorline = true

-- Clipboard
opt.clipboard:append('unnamedplus')

-- Wrap
opt.wrap = true
opt.wrapscan = true

-- Remove auto comments
vim.api.nvim_create_autocmd('FileType', { command = 'set formatoptions=' })

-- Drop Down Menu
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Column
opt.colorcolumn = '80'
opt.signcolumn = 'number'
opt.synmaxcol = 240

-- updatetime
opt.updatetime = 50

-- Vim File Explorer
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25

-- Gives more space for displaying messages
opt.cmdheight = 1

-- Scroll
opt.scrolloff = 10

-- Bells
opt.errorbells = false
