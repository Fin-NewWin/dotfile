local options = {
	backup = false, -- Don't create backup file
	breakindent = true, -- Wrap lines have same indent
	clipboard = "unnamedplus", -- use system clipboard
	cmdheight = 0, -- Height when using cmd
	colorcolumn = "120", -- vertical column that suggests column limit
	cursorline = true, -- cursorline that's it
	errorbells = false, -- no beep
	foldenable = false, -- fold
	ignorecase = true, -- ignore case when searching
	laststatus = 3, -- global staths
	mouse = "", -- mouse
	mousemoveevent = true, -- mouse location matters
	number = true, -- number line
	pumheight = 10, -- pop menu height
	relativenumber = true, -- number line with relative lines
	shiftwidth = 4, -- tab
	showmode = false, -- mode bottom left of cmd but I have statusline
	sidescrolloff = 8, -- similar to scrolloff but horizontal scrolling
	signcolumn = "yes", -- permanent signcolumn
	smartcase = true, -- case sensitive when uppercase
	smartindent = true, -- Indent true
	swapfile = false, -- disable swap
	syntax = "OFF", -- Treesistter for suntax
	tabstop = 4, -- tab
	termguicolors = true, -- true colors
	timeoutlen = 400, -- Keys time out
	undofile = true, -- undo file
	updatetime = 250, -- key press timeout
	wrap = true, -- enable wrap
	writebackup = false, -- disable backup
}

-- Disable nvim intro
vim.opt.shortmess:append("csI")

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.loader.enable()
