local au = vim.api.nvim_create_autocmd

-- Remove auto comments
au("FileType", { command = "set formatoptions-=cro" })

-- Remove trailing white space
au("BufWritePre", { command = [[%s/\s\+$//e]] })

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
au('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

au("FileType", { pattern = "yaml", command = "setlocal ts=4 sts=4 sw=4 expandtab" })

-- Enable spell checking for certain file types
au({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" })
