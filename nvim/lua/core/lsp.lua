-- Diagnostics
vim.diagnostic.config({
	virtual_lines = true,
	severity_sort = true,
})

-- keybinds
local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
		keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definition
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts) -- jump to previous diagnostic in buffer
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts) -- jump to next diagnostic in buffer
		keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
	end,
})

-- default root markers for lsp
vim.lsp.config("*", {
	root_markers = { ".git" },
})

-- LSP: see /after/plugin/[lsp].lua
vim.lsp.enable("lua_ls")
