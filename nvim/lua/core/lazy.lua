-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"git@github.com:folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugin" },
	},
	defaults = {
		lazy = true,
	},
	checker = {
		enabled = false,
	},
	debug = false,
	change_detection = {
		notify = false,
	},
})
