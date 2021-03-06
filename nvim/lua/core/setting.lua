local options = {
    conceallevel = 0,
    termguicolors = true,
    pumheight = 10,
    showmode = false,                        
    ruler = true,
    number = true,
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
    clipboard = 'unnamedplus',
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Remove auto comments
vim.api.nvim_create_autocmd('FileType', { command = 'set formatoptions=' })
