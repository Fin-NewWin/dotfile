-- Sort imports
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local group_imp_org = augroup("TSServerOrganizeImports", { clear = true })

autocmd("BufWritePre", {
	group = group_imp_org,
	desc = "TSServerOrganizeImports",
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function()
		-- vim.notify("This is running and shit")
		organize_imports()
	end,
})

-- FIX: find a way to autoimport
-- local group_imp_miss = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true })
-- autocmd("BufWritePre", {
-- 	group = group_imp_miss,
-- 	desc = "TS_add_missing_imports",
-- 	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
-- 	callback = function()
-- 		vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" } } })
-- 		vim.cmd("write")
-- 	end,
-- })
