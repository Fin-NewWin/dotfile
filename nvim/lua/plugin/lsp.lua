return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = false,

        dependencies = {
            "neovim/nvim-lspconfig",
            {
                "folke/neodev.nvim",
                opts = {
                    debug = true,
                    experimental = {
                        pathStrict = true,
                    },

                },
                config = true,
            },
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",

            "onsails/lspkind.nvim",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            "rafamadriz/friendly-snippets",
        },
        config = function()
            local lsp = require("lsp-zero").preset({})

            lsp.preset("recommended")

            lsp.nvim_workspace()

            lsp.ensure_installed({
                "tsserver",
                "eslint",
                "cssls",
                "html",

                "clangd",

                "bashls",

                "texlab",

                "lua_ls",

                "efm"
            })

            local cmp = require('cmp')
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            })

            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            })

            cmp_mappings['<Tab>'] = nil
            cmp_mappings['<S-Tab>'] = nil

            lsp.setup_nvim_cmp({
                mapping = cmp_mappings,
                documentation = true,
                use_luasnip = true,
            })

            lsp.float_border = "rounded"


            lsp.configure("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            rope_completion = {
                                enabled = true,
                            },
                            pyflakes = {
                                enabled = true,
                            },
                            flake8 = {
                                enabled = true,
                                ignore = {
                                    "E303",
                                    "D401",
                                    "D403",
                                    "E501",
                                },
                            },
                            pylint = {
                                enabled = true,
                                args = {
                                    "--generate-members",
                                },
                            },
                            mypy = {
                                enabled = true,
                            },
                            pycodestyle = {
                                enabled = true,
                                ignore = {
                                    "E303",
                                    "E501",
                                },
                            },
                        },
                    },
                },
            })

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
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
                vim.keymap.set("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, opts)

                -- Tell that the buffer is loaded
                vim.api.nvim_create_autocmd({ "LspAttach" }, {
                    callback = function()
                        return true
                    end,
                })
            end)


            require("neodev").setup()
            lsp.setup()

            local _border = "rounded"

            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { focusable = false, border = _border })
            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })

            require("lspconfig.ui.windows").default_options.border = "rounded"

            local signs = {
                Error = "󰅚",
                Warn = "󰀪",
                Hint = "󰌶",
                Info = "",
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                virtual_text = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            require("lspsaga").setup({
                lightbulb = {
                    enable = false,
                },
            })
        end,
    },
    {
        "ivanjermakov/troublesum.nvim",
        event = "LspAttach",
        opts = {
            severity_format = {
                "󰅚",
                "󰀪",
                "󰌶",
                "",

            },
        },
        config = true,
    },
    {
        "mfussenegger/nvim-jdtls",
    }
}
