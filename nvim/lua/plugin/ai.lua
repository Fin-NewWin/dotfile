return {
	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup({
				enabled = function()
					local disabled = {
						IncRename = true,
					}
					local cmd = vim.fn.getcmdline():match("%S+")
					return not disabled[cmd]
				end,
			})
			vim.keymap.set("i", "<C-Space>", neocodeium.accept)
		end,
	},
}
