local options = {
    conceallevel = 0,
    termguicolors = true,
    pumheight = 10,
    showmode = false,
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
    -- signcolumn = 'number',
    synmaxcol = 240,
    updatetime = 50,
    cmdheight = 1,
    scrolloff = 10,
    errorbells = false,
    clipboard = 'unnamedplus',
    laststatus = 2,
    syntax = "OFF",
    mouse = "",
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end
