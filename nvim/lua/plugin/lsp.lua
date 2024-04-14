return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

			local on_attach = function(client, bufnr)
				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local key = vim.keymap.set

				key("n", "gD", vim.lsp.buf.declaration, opts)
				key("n", "gd", vim.lsp.buf.definition, opts)
				key("n", "gi", vim.lsp.buf.implementation, opts)

				key("n", "gt", vim.lsp.buf.type_definition, opts)
				key("n", "<leader>rn", vim.lsp.buf.rename, opts)
				key("n", "gr", vim.lsp.buf.references, opts)

				key("n", "<leader>q", vim.diagnostic.setloclist)
			end

			local servers = {
				"cssls",
				"tailwindcss",
				"html",

				"texlab",

				"lua_ls",

				"pyright",
				"ruff_lsp",

				"clangd",
				"jdtls",
			}

			for _, lsp in ipairs(servers) do
				require("lspconfig")[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			local lsp = require("lspconfig")

			lsp["tsserver"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				single_file_support = false,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "literal",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})

			lsp["pyright"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							diagnosticSeverityOverrides = {
								reportUnusedExpression = "none", -- this removes a really annoying warning in notebook type files
							},
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})

			lsp["bashls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					bashIde = {
						shellcheckArguments = {
							"-e",
							"SC1090,SC2148,SC2016",
						},
					},
				},
			})

			require("neodev").setup()

			vim.diagnostic.config({
				virtual_text = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					source = true,
					header = "",
					prefix = "",
				},
			})
		end,
	},
	{
		"wookayin/semshi", -- maintained fork
		ft = "python",
		build = ":UpdateRemotePlugins", -- don't disable `rplugin` in lazy.nvim for this
		init = function()
			-- better done by LSP
			vim.g["semshi#error_sign"] = false

			vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
				callback = function()
					vim.cmd([[
						highlight! semshiGlobal gui=italic
						" highlight! link semshiImported @lsp.type.namespace
						" highlight! link semshiParameter @lsp.type.parameter
						" highlight! link semshiParameterUnused DiagnosticUnnecessary
						" highlight! link semshiBuiltin @function.builtin
						" highlight! link semshiAttribute @field
						highlight! link semshiSelf @lsp.type.selfKeyword
						" highlight! link semshiUnresolved @lsp.type.unresolvedReference
						" highlight! link semshiFree @comment
					]])
				end,
			})
		end,
	},
}
