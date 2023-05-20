return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "*",
        lazy = false,

        dependencies = {
            "neovim/nvim-lspconfig",
            "folke/neodev.nvim",
            "ray-x/lsp_signature.nvim",
            "lvimuser/lsp-inlayhints.nvim",
        },
        config = function()
            local lsp = require("lsp-zero").preset({})

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = false,
            })

            lsp.setup_servers({
                "tsserver",
                "eslint",
                "cssls",
                "html",

                "clangd",

                "bashls",

                "texlab",
            })

            lsp.configure("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "_" },
                        },
                    },
                },
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

            lsp.configure("efm", {})

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
                -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>rn", function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, opts)

                require("lsp_signature").on_attach({
                    bind = true,
                    handler_opts = {
                        border = "rounded",
                    },
                    fix_pos = true,
                    hint_prefix = "",
                    floating_window_off_x = 5, -- adjust float windows x position.
                    floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
                        local pumheight = vim.o.pumheight
                        local winline = vim.fn.winline() -- line number in the window
                        local winheight = vim.fn.winheight(0)

                        -- window top
                        if winline - 1 < pumheight then
                            return pumheight
                        end

                        -- window bottom
                        if winheight - winline < pumheight then
                            return -pumheight
                        end
                        return 0
                    end,
                }, bufnr)

                require("lsp-inlayhints").on_attach(client, bufnr, false)
            end)

            lsp.nvim_workspace()

            require("neodev").setup()
            lsp.setup()

            local _border = "rounded"

            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { focusable = false, border = _border })
            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })

            require('lspconfig.ui.windows').default_options.border = 'rounded'


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
}
