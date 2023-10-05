return {
	{
		"VonHeikemen/lsp-zero.nvim",
		version = false,
        event = {'BufReadPre', 'BufNewFile'},
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",

			"rafamadriz/friendly-snippets",

			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lsp = require("lsp-zero")

			lsp.preset("recommended")

			lsp.ensure_installed({
				"tsserver",
				"emmet_ls",
				"cssls",
				"tailwindcss",
				"html",

				"clangd",

				"bashls",

				"texlab",

				"lua_ls",

				"pyright",

				"jdtls",
			})

			lsp.nvim_workspace()

			local cmp = require("cmp")

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local cmp_mappings = lsp.defaults.cmp_mappings({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
			})

			cmp_mappings["<Tab>"] = nil
			cmp_mappings["<S-Tab>"] = nil

			lsp.setup_nvim_cmp({
				mapping = cmp_mappings,
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},
			})

			lsp.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = {
					error = "E",
					warn = "W",
					hint = "H",
					info = "I",
				},
			})

			-- lsp.on_attach(function(client, bufnr)
			lsp.on_attach(function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }
				local key = vim.keymap.set

				key("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				key("n", "]d", function()
					vim.diagnostic.goto_next()
				end, opts)
				key("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, opts)
				key("n", "<leader>rn", function()
					vim.lsp.buf.rename()
				end, opts)
				key("n", "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, opts)
			end)

			lsp.setup()

			require("mason-lspconfig").setup()

			vim.diagnostic.config({
				virtual_text = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
	},
}
