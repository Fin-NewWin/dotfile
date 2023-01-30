return {
    {
        "VonHeikemen/lsp-zero.nvim",
        -- event = "VeryLazy",
        lazy = false,
        dependencies = {
            "neovim/nvim-lspconfig",

            -- Additional plugins
            "folke/neodev.nvim",
            "ray-x/lsp_signature.nvim",
            "lvimuser/lsp-inlayhints.nvim",
        },
        config = function()
            local lsp = require("lsp-zero")


            lsp.preset("recommended")

            lsp.set_preferences({
                suggest_lsp_servers = false,
                setup_servers_on_start = false,
                call_servers = 'global',
                sign_icons = false,
            })

            lsp.setup_servers({
                "tsserver",
                "eslint",

                "clangd",

                "bashls",
                "dockerls",

            })

            lsp.configure('sumneko_lua', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "_" },
                        },
                    },
                }
            })

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
                                    "D403"
                                },
                            },
                            pylint = {
                                enabled = true,
                            },
                            mypy = {
                                enabled = true,
                            },
                            pycodestyle = {
                                enabled = true,
                                ignore = { "E303" }
                            }
                        }
                    }
                }
            })

            lsp.configure("efm", {
                filetypes = { 'sh' },
                settings = {
                    rootMarkers = { ".git/" },
                }
            })


            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover({focusable = false}) end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end

                require("lsp_signature").on_attach({
                    bind = true,
                    handler_opts = {
                        border = "rounded"
                    },
                    fix_pos = true,
                    hint_prefix = "",
                }, bufnr)

                require("lsp-inlayhints").on_attach(client, bufnr, _)

            end)



            lsp.nvim_workspace()

            require("neodev").setup()
            lsp.setup()

            local _border = "rounded"

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with( vim.lsp.handlers.hover, { focusable = false, border = _border })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with( vim.lsp.handlers.signature_help, { border = _border })
            require('lspconfig.ui.windows').default_options.border = "rounded"

            local signs = {
                Error = "",
                Warn  = "",
                Hint  = "",
                Info  = "",
            }

            vim.diagnostic.config({
                virtual_text = true,
                active = signs,
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
        end
    },
}
