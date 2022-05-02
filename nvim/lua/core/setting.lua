local opt = vim.opt
local g = vim.g

local options = {
    termguicolors = true,
    pumheight = 10,
    ruler = true,
    number = true,
    relativenumber = true,
    linebreak = true,
    breakindent = true,
    tabstop = 4,
    softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	backup = false,
	swapfile = false,
	undofile = true,
	fileformat = 'unix',
	encoding = 'UTF-8',
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    cursorline = true,
    wrap = true,
    wrapscan = true,
    completeopt = { 'menu', 'menuone', 'noselect' },
    colorcolumn = '80',
    signcolumn = 'number',
    synmaxcol = 240,
    updatetime = 50,
    cmdheight = 1,
    scrolloff = 10,
    errorbells = false,
    clipboard = opt.clipboard + 'unnamedplus',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Need this for everything
vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
vim.go.t_8b = "[[48;2;%lu;%lu;%lum"

-- Clipboard
-- opt.clipboard:append('unnamedplus')

-- Remove auto comments
vim.api.nvim_create_autocmd('FileType', { command = 'set formatoptions=' })
