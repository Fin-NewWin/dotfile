local key = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Exit terminal
key("t", "<Esc>", "<CMD>ToggleTerm<CR>", term_opts)
key("t", "<C-[>", "<CMD>ToggleTerm<CR>", term_opts)
key("t", "<C-o>", "")
key("t", "<C-i>", "")

-- Navigate between splits on term
key("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
key("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
key("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
key("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Navigate between splits
key("n", "<C-h>", "<C-w>h", opts)
key("n", "<C-j>", "<C-w>j", opts)
key("n", "<C-k>", "<C-w>k", opts)
key("n", "<C-l>", "<C-w>l", opts)

-- esc to hide matches
key("n", "<Esc>", ":noh<CR>", term_opts)
key("n", "<C-[>", ":noh<CR>", term_opts)

-- Stay in indent mode
key("v", ">", ">gv", opts)
key("v", "<", "<gv", opts)

-- Select All
key("n", "<C-a>", "gg<S-v>G", opts)

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

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
key("n", "n", "'Nn'[v:searchforward]", { expr = true })
key("x", "n", "'Nn'[v:searchforward]", { expr = true })
key("o", "n", "'Nn'[v:searchforward]", { expr = true })
key("n", "N", "'nN'[v:searchforward]", { expr = true })
key("x", "N", "'nN'[v:searchforward]", { expr = true })
key("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Re-do on the same key
key("n", "U", "<C-r>", opts)

-- Remove Keybindings
key("n", "<S-k>", "<Nop>", opts)
key("n", "<C-[", "<Nop>", opts)
key("n", "Q", "<Nop>", opts)
key("n", "<C-r>", "<Nop>", opts)
