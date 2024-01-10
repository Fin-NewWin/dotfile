return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local types = require("cmp.types")
			local function limit_lsp_types(entry, ctx)
				local kind = entry:get_kind()
				local line = ctx.cursor.line
				local col = ctx.cursor.col
				local char_before_cursor = string.sub(line, col - 1, col - 1)
				local char_after_dot = string.sub(line, col, col)

				if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
					if
						kind == types.lsp.CompletionItemKind.Method
						or kind == types.lsp.CompletionItemKind.Field
						or kind == types.lsp.CompletionItemKind.Property
					then
						return true
					else
						return false
					end
				elseif string.match(line, "^%s+%w+$") then
					if kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable then
						return true
					else
						return false
					end
				end

				return true
			end

			local keys = {
				["<C-n>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_next_item()
					else
						cmp.complete()
					end
				end),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-c>"] = cmp.mapping.close(),
				["<C-y>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = false,
				}),
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = {
						col_offset = -2,
						scrollbar = false,
					},
					documentation = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},

				mapping = keys,
				sources = {
					{
						name = "nvim_lsp",
						priority = 10,
						entry_filter = limit_lsp_types,
					},
					{ name = "luasnip", priority = 7 },
					{ name = "nvim_lua", priority = 5 },
					{ name = "path", priority = 4 },
					{ name = "buffer", priority = 3 },
				},

				require("luasnip.loaders.from_vscode").lazy_load(),
			})
		end,
	},
}
