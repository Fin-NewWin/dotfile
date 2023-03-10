local key = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Exit terminal and return to last
key("t", "<Esc>", "<C-\\><C-n><C-o>", opts)
key("t", "<C-[>", "<C-\\><C-n><C-o>", opts)

-- Navigate between splits on term
key("t", "<Leader>h", "<C-\\><C-n><C-w>h", opts)
key("t", "<Leader>j", "<C-\\><C-n><C-w>j", opts)
key("t", "<Leader>k", "<C-\\><C-n><C-w>k", opts)
key("t", "<Leader>l", "<C-\\><C-n><C-w>l", opts)

-- Navigate between splits
key("n", "<Leader>h", "<C-w>h", opts)
key("n", "<Leader>j", "<C-w>j", opts)
key("n", "<Leader>k", "<C-w>k", opts)
key("n", "<Leader>l", "<C-w>l", opts)

-- esc to hide matches
key("n", "<Esc>", ":noh<CR>", term_opts)
key("n", "<C-[>", ":noh<CR>", term_opts)

-- Stay in indent mode
key("v", ">", ">gv", opts)
key("v", "<", "<gv", opts)

-- Select All
key("n", "<C-a>", "gg<S-v>G", opts)

-- Remove Keybindings
key("n", "<S-k>", "<Nop>", opts)
key("n", "<C-[", "<Nop>", opts)
key("n", "Q", "<Nop>", opts)

-- move bottom line to this line
key("n", "J", "mzJ`z")

-- Navigate begin/end of line
key({ "n", "v", "o" }, "H", "^")
key({ "n", "v", "o" }, "L", "$")

-- Center when move
key("n", "<C-d>", "<C-d>zz")
key("n", "<C-u>", "<C-u>zz")
key("n", "{", "{zz")
key("n", "}", "}zz")
key("n", "n", "nzzzv")
key("n", "N", "Nzzzv")

-- system clipboard
key("n", "<leader>p", '"+p')
key({ "n", "v" }, "<leader>y", '"+y')
key("n", "<leader>Y", '"+Y')
key({ "n", "v" }, "<leader>d", '"_d')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
key("n", "n", "'Nn'[v:searchforward]", { expr = true })
key("x", "n", "'Nn'[v:searchforward]", { expr = true })
key("o", "n", "'Nn'[v:searchforward]", { expr = true })
key("n", "N", "'nN'[v:searchforward]", { expr = true })
key("x", "N", "'nN'[v:searchforward]", { expr = true })
key("o", "N", "'nN'[v:searchforward]", { expr = true })
