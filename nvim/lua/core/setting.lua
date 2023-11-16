local options = {
  backup = false,              -- Don't create backup file
  breakindent = true,          -- Wrap lines have same indent
  clipboard = "unnamedplus",   -- use system clipboard
  cmdheight = 0,               -- Height when using cmd
  colorcolumn = "120",         -- vertical column that suggests column limit
  cursorline = true,           -- cursorline that's it
  errorbells = false,          -- no beep
  expandtab = true,            -- tabs to spaces
  fillchars = {
    eob = " ",                 -- end of buffer char = space
  },
  foldenable = false,          -- fold
  ignorecase = true,           -- ignore case when searching
  laststatus = 3,              -- global staths
  mouse = "",                  -- enables mouse
  mousemoveevent = true,       -- mouse location matters
  number = true,               -- number line
  pumheight = 10,              -- pop menu height
  relativenumber = true,       -- number line with relative lines
  scrolloff = 8,               -- number of lines before scrolling
  shiftwidth = 2,              -- tab
  showmode = false,            -- mode bottom left of cmd but I have statusline
  sidescrolloff = 8,           -- similar to scrolloff but horizontal scrolling
  signcolumn = "yes",          -- permanent signcolumn
  smartcase = true,            -- case sensitive when uppercase
  smartindent = true,          -- Indent true
  softtabstop = 2,             -- tab
  swapfile = false,            -- disable swap
  syntax = "OFF",              -- Treesistter for suntax
  tabstop = 2,                 -- tab
  termguicolors = true,        -- true colors
  timeoutlen = 400,            -- Keys time out
  undofile = true,             -- undo file
  updatetime = 250,            -- key press timeout
  wrap = true,                 -- enable wrap
  writebackup = false,         -- disable backup
}

-- Disable nvim intro
vim.opt.shortmess:append("csI")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.loader.enable()
