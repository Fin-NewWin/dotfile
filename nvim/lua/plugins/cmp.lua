return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "onsails/lspkind.nvim",
        "lukas-reineke/cmp-under-comparator",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if not cmp_status_ok then
            vim.notify("cmp not in path", 4, { title = "Plugin Error" })
            return
        end

        local snip_status_ok, luasnip = pcall(require, "luasnip")
        if not snip_status_ok then
            vim.notify("luasnip not in path", 4, { title = "Plugin Error" })
            return
        end

        local ok, lspkind = pcall(require, "lspkind")
        if not ok then
            vim.notify("lspkind not in path", 4, { title = "Plugin Error" })
            return
        end

        luasnip.config.setup({
            history = true,
            enable_autosnippets = true,
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup {
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:None,FloatBorder:None,CursorLine:CursorLine,Search:None",
                    scrollbar = false,
                },
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            formatting = {
                format = lspkind.cmp_format(),
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    require "cmp-under-comparator".under,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            sources = {
                { name = "path" },
                { name = "nvim_lsp", keyword_length = 3 },
                { name = "nvim_lsp_signature_help", keyword_length = 3 },
                { name = "buffer", keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
                { name = "nvim_lua" },
            },
            mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true)
                            , "")
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            },
        }
    end
}
