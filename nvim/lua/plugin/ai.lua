return {
	{
		"monkoose/neocodeium",
		event = "InsertEnter",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup({
				show_label = false,
			})
			vim.keymap.set("i", "<C-Space>", neocodeium.accept)
		end,
	},
}
