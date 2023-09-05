---@diagnostic disable: missing-fields

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = false,

        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            "rafamadriz/friendly-snippets",

            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

        },
        config = function()
            local lsp = require("lsp-zero").preset({})

            lsp.preset("recommended")

            lsp.ensure_installed({
                "tsserver",
                "eslint",
                "cssls",
                "html",

                "clangd",

                "bashls",

                "texlab",

                "lua_ls",

                "pylsp"
            })

            lsp.nvim_workspace()

            local cmp = require("cmp")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })

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
                documentation = false,
                use_luasnip = true,
            })

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_prev()
                end, opts)
                vim.keymap.set("n", "<leader>rn", function()
                    vim.lsp.buf.rename()
                end, opts)

                -- Tell that the buffer is loaded
                vim.api.nvim_create_autocmd({ "LspAttach" }, {
                    callback = function()
                        return true
                    end,
                })
            end)

            lsp.setup()


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
