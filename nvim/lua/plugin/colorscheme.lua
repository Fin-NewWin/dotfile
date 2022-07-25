local function colorscheme(name)
    vim.g.colors_name = name
    vim.o.background = vim.o.background
end
colorscheme('gruvbox')

vim.api.nvim_set_hl(0, "NormalFloat", { bg="NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg="NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { TelescopeBorder })

-- GitSigns bg removal
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg="#b8bb26", bg="NONE" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg="#fe8019", bg="NONE" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg="#fb4934", bg="NONE" })
