-- Diagnostics
vim.diagnostic.config({
	virtual_lines = true,
	severity_sort = true,
})

-- default root markers for lsp
vim.lsp.config("*", {
	root_markers = { ".git" },
})

-- LSP: see /after/plugin/[lsp].lua
vim.lsp.enable("lua_ls")
