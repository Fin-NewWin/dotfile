local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Filetype
-- nesC not supported, temp make it into filetype "c"
autocmd({ "BufEnter" }, {
	pattern = {
		"*.nc",
	},
	callback = function()
		vim.bo.filetype = "c"
	end,
})

autocmd("BufWritePre", {
	desc = "Remove trailing spaces",
	command = "%s/\\s\\+$//e",
})

autocmd("BufEnter", {
	desc = "Remove auto comments",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

autocmd("TermOpen", {
	desc = "Terminal settings",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd("startinsert!")
	end,
})

local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	desc = "Highlight yank",
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

autocmd("FocusGained", {
	desc = "Update file when there are changes",
	callback = function()
		vim.cmd("checktime")
	end,
})

-- TODO: Fix later if doesn't work for yaml
-- autocmd("FileType", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.opt_local.expandtab = false
-- 		vim.opt_local.shiftwidth = 2
-- 		vim.opt_local.tabstop = 2
-- 		vim.opt_local.softtabstop = 2
-- 	end,
-- })

autocmd({ "BufRead", "BufNewFile" }, {
	desc = "Enable spell checking in filetypes",
	pattern = { "*.txt", "*.md", "*.tex" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

autocmd({ "InsertLeave", "WinEnter" }, {
	desc = "Show cursor line only in active window",
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
	desc = "Disable cursorline when buffer not focused",
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
})

autocmd({ "FileType" }, {
	desc = "Fix conceallevel for json and help files",
	pattern = { "json", "jsonc" },
	callback = function()
		vim.wo.spell = false
		vim.wo.conceallevel = 0
	end,
})

autocmd("BufReadPost", {
	desc = "Return to last edit location",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- not really an autocmd
-- Remove hlsearch when not searching
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")

local function toggle_hlsearch(char)
	if vim.fn.mode() == "n" then
		local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
		local if_search = vim.tbl_contains(keys, vim.fn.keytrans(char))

		vim.opt.hlsearch = if_search
	end
end

vim.on_key(toggle_hlsearch, ns)

-- Disable options if large file
local group = vim.api.nvim_create_augroup("LargeFileAutocmds", {})
local old_eventignore = vim.o.eventignore
local largefile_opened = false
local largefile_size = 1024 * 1024

autocmd({ "BufReadPre" }, {
	group = group,
	callback = function(ev)
		if ev.file then
			local status, size = pcall(function()
				return vim.loop.fs_stat(ev.file).size
			end)
			if status and size > largefile_size then -- large file
				vim.wo.wrap = false
				old_eventignore = vim.o.eventignore
				largefile_opened = true
				vim.o.eventignore = "FileType"
				vim.bo.swapfile = false
				vim.bo.bufhidden = "unload"
				vim.bo.buftype = "nowrite"
				vim.bo.undolevels = -1
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = group,
	callback = function(ev)
		if largefile_opened then
			largefile_opened = false
			vim.o.eventignore = nil
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = group,
	callback = function(ev)
		local byte_size = vim.api.nvim_buf_get_offset(ev.buf, vim.api.nvim_buf_line_count(ev.buf))
		if byte_size > largefile_size then
			if vim.g.loaded_matchparen then
				vim.g.loaded_matchparen = false
			end
		else
			if not vim.g.loaded_matchparen then
				vim.g.loaded_matchparen = true
			end
		end
	end,
})
