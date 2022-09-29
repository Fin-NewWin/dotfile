local key = vim.keymap.set
local opts = {noremap = true, silent = true}

-- Leader key
key({ 'n', 'v' }, '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Exit terminal and return to last
key('t', '<Esc>', '<C-\\><C-n><C-o>', opts)

-- Navigate between splits on term
key('t', '<Leader>h', '<C-\\><C-n><C-w>h', opts)
key('t', '<Leader>j', '<C-\\><C-n><C-w>j', opts)
key('t', '<Leader>k', '<C-\\><C-n><C-w>k', opts)
key('t', '<Leader>l', '<C-\\><C-n><C-w>l', opts)

-- Navigate between splits
key('n', '<Leader>h', '<C-w>h', opts)
key('n', '<Leader>j', '<C-w>j', opts)
key('n', '<Leader>k', '<C-w>k', opts)
key('n', '<Leader>l', '<C-w>l', opts)

key('n', '<Leader>z', ':lua require("nabla").popup()<CR>', opts)

--Remap for dealing with word wrap
key('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
key('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
