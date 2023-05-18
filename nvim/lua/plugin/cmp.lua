return {
    "hrsh7th/nvim-cmp",
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",

        "onsails/lspkind.nvim",
        "lukas-reineke/cmp-under-comparator",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        luasnip.config.setup({
            history = true,
            enable_autosnippets = true,
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:None,FloatBorder:None,CursorLine:CursorLine,Search:None",
                    scrollbar = false,
                },
                documentation = cmp.config.window.bordered(),
            },
            present = "codicons",
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
                    require("cmp-under-comparator").under,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            sources = {
                {
                    name = "nvim_lsp",
                    priority = 1000,
                },
                {
                    name = "luasnip",
                    priority = 750,
                },
                {
                    name = "buffer",
                    priority = 500,
                },
                {
                    name = "path",
                    priority = 250,
                },
            },
            mapping = {
                ["<C-p>"] = cmp.mapping(
                    cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    { "i" }
                ),
                ["<C-n>"] = cmp.mapping(
                    cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    { "i" }
                ),
                ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline({
                ["<C-p>"] = function()
                    return nil
                end,
                ["<C-n>"] = function()
                    return nil
                end,
            }),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
                ["<C-p>"] = function()
                    return nil
                end,
                ["<C-n>"] = function()
                    return nil
                end,
            }),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                },
            }),
        })
    end,
}
