return {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.g.codeium_disable_bindings = 1
			vim.keymap.set("i", "<C-Space>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			-- FIX: xdg is not working
			-- vim.keymap.set("n", "<C-p>", function()
			-- 	return vim.fn["codeium#command#HomeDir"]()
			-- end, { expr = true })
		end,
	},
}
