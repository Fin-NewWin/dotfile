return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPost",
        dependencies = {
            "folke/neodev.nvim",
            "ray-x/lsp_signature.nvim",
            "lvimuser/lsp-inlayhints.nvim",
        },
        config = function()
            local status_ok, lspconfig = pcall(require, "lspconfig")
            if not status_ok then
                vim.notify("lspconfig not in path", 4, { title = "Plugin Error" })
                return
            end

            -- Border Hover
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function orig_util_open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            require("lspconfig.ui.windows").default_options.border = "rounded"


            -- LSP diagnostics signs
            local signs = {
                Error = "",
                Warn  = "",
                Hint  = "",
                Info  = "",
            }

            vim.diagnostic.config = {
                virtual_text = false,
                signs = {
                    active = signs,
                },
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
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end


            -- Pipe commands into telescope
            -- vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references


            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local key = vim.keymap.set
            local opts = { noremap = true, silent = true }
            key("n", "<space>e", vim.diagnostic.open_float, opts)
            key("n", "[d", vim.diagnostic.goto_prev, opts)
            key("n", "]d", vim.diagnostic.goto_next, opts)
            key("n", "<space>q", vim.diagnostic.setloclist, opts)

            local on_attach = function(client, bufnr)

                client.server_capabilities.documentFormattingProvider = true

                local navic_ok, navic = pcall(require, "nvim-navic")
                if navic_ok then
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                    end
                end

                local sig_ok, lsp_signature = pcall(require, "lsp_signature")
                if sig_ok then
                    lsp_signature.on_attach({
                        bind = true,
                        handler_opts = {
                            border = "rounded"
                        },
                        fix_pos = true,
                        hint_prefix = "",
                    }, bufnr)
                end
                require("lsp-inlayhints").on_attach(client, bufnr)




                local bufopts = { noremap = true, silent = true, buffer = bufnr }

                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                key("n", "gd", vim.lsp.buf.definition, bufopts)

                key("n", "gr", require('telescope.builtin').lsp_references, bufopts)
                key("n", "gi", vim.lsp.buf.implementation, bufopts)
                key("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
                key("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                key("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
                key("n", "<C-s>", "<cmd>Format<cr>", bufopts)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()

            local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if cmp_nvim_lsp_ok then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end



            local lspflags = {
                debounce_text_changes = 500,
            }

            local servers = {
                "tsserver",
                "eslint",
                "clangd",

                "dockerls",
            }


            for _, server in pairs(servers) do
                lspconfig[server].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    flags = lspflags,
                }
            end

            local neodev_ok, neodev = pcall(require, "neodev")
            if neodev_ok then
                neodev.setup()
            end

            lspconfig["sumneko_lua"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                flags = lspflags,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                        completion = {
                            workspaceWord = true,
                            callSnippet = "Both",
                        },
                    },
                },
            })

            lspconfig["pylsp"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = lspflags,
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
                                ignore = { "E303", "D401", "D403" },
                                enabled = true,
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
            }

            lspconfig["efm"].setup({
                init_options = { documentFormatting = true },
                filetypes = { 'sh' },
                settings = {
                    rootMarkers = { ".git/" },
                }
            })

            -- Disable diagnostics in node_modules (0 is current buffer only)
            vim.api.nvim_create_autocmd("BufRead",
                { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
            vim.api.nvim_create_autocmd("BufNewFile",
                { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
        end
    },
}
