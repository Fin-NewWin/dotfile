local servers = {
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
}

return {
	{
		"neovim/nvim-lspconfig",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local on_attach = function(_, bufnr)
				vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local key = vim.keymap.set

				key("n", "gD", vim.lsp.buf.declaration, opts)
				key("n", "gd", vim.lsp.buf.definition, opts)
				key("n", "gi", vim.lsp.buf.implementation, opts)

				key("n", "gt", vim.lsp.buf.type_definition, opts)
				key("n", "<leader>rn", vim.lsp.buf.rename, opts)
				key("n", "<leader>l", vim.lsp.buf.code_action, opts)
				key("n", "gr", vim.lsp.buf.references, opts)
			end

			for _, lsp in ipairs(servers) do
				require("lspconfig")[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			local lsp = require("lspconfig")

			lsp["lua_ls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "require", "P", "R" },
						},
						workspace = {
							checkThirdParty = false,
						},
					},
				},
			})

			lsp["tsserver"].setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.semanticTokensProvider = function()
						return {}
					end
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
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
		end,
	},
}
