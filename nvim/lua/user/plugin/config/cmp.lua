local M = {}

function M.config()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
        return
    end

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
        return
    end

    local ok, lspkind = pcall(require, "lspkind")
    if not ok then
        return
    end

    luasnip.config.set_config({
        region_check_events = 'InsertEnter',
        delete_check_events = 'InsertLeave'
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
            format = lspkind.cmp_format {
                maxwidth = 40,
                with_text = true,
                menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[api]",
                    path = "[path]",
                    luasnip = "[snip]",
                    gh_issues = "[issues]",
                    tn = "[TabNine]",
                },

            },
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
            { name = "buffer", keyword_length = 3 },
            { name = "luasnip", keyword_length = 2 },
            { name = "nvim_lua" },
        },
        mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
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

return M
