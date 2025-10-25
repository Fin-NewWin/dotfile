vim.lsp.enable('lua_ls')
-- Diagnostics
vim.diagnostic.config({
	-- Use the default configuration
	virtual_lines = true,
	severity_sort = true,

	-- Alternatively, customize specific options
	-- virtual_lines = {
	-- 	-- Only show virtual line diagnostics for the current cursor line
	-- 	current_line = true,
	-- },
})
