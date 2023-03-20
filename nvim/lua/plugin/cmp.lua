return {
    "hrsh7th/nvim-cmp",
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-calc",
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
                { name = "path" },
                { name = "nvim_lsp", keyword_length = 3 },
                { name = "nvim_lsp_signature_help", keyword_length = 3 },
                { name = "calc" },
                { name = "buffer", keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
                { name = "nvim_lua" },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
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
            }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })
    end,
}
