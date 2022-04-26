local key = vim.keymap.set

-- Leader key
key({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Exit terminal and return to last
key('t', '<Esc>', '<C-\\><C-n><C-o>', {noremap = true})

-- Navigate between splits on term
key('t', '<Leader>h', '<C-\\><C-n><C-w>h', {noremap = true})
key('t', '<Leader>j', '<C-\\><C-n><C-w>j', {noremap = true})
key('t', '<Leader>k', '<C-\\><C-n><C-w>k', {noremap = true})
key('t', '<Leader>l', '<C-\\><C-n><C-w>l', {noremap = true})

-- Navigate between splits
key('n', '<Leader>h', '<C-w>h', {noremap = true})
key('n', '<Leader>j', '<C-w>j', {noremap = true})
key('n', '<Leader>k', '<C-w>k', {noremap = true})
key('n', '<Leader>l', '<C-w>l', {noremap = true})

key('n', '<Leader>z', ':lua require("nabla").popup()<CR>', {noremap = true})

--Remap for dealing with word wrap
key('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
key('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
