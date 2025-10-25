return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		{
			".luarc.json",
			".luarc.jsonc",
		},
		".git",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
					"${3rd}/busted/library",
				},
			},
		},
	},
}
