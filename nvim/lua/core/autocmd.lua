local au = vim.api.nvim_create_autocmd

-- Remove auto comments
au('FileType', { command = 'set formatoptions=' })

-- Remove trailing white space
au('BufWritePre', { command = [[%s/\s\+$//e]] })

-- Reload file when chaned outside of nvim
au({'BufEnter', 'CursorHold'}, { command = 'silent! checktime %'})
