local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

-- Border Hover
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
require('lspconfig.ui.windows').default_options.border = 'rounded'


-- LSP diagnostics signs
local signs = {
    Error   =   "",
    Warn    =   "",
    Hint    =   "",
    Info    =   "",
}

vim.diagnostic.config = {
    virtual_text = true,
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
vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local key = vim.keymap.set
local on_attach = function(client, bufnr)

    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = false

    local navic_ok, navic = pcall(require, "nvim-navic")
    if navic_ok then
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
    end

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    key('n', 'gD', vim.lsp.buf.declaration, bufopts)
    key('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- key('n', 'K', vim.lsp.buf.hover, bufopts)
    key('n', 'gi', vim.lsp.buf.implementation, bufopts)
    key('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    key('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    key('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}
capabilities.textDocument.codeAction = {
    dynamicRegistration = false,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = {
                "",
                "quickfix",
                "refactor",
                "refactor.extract",
                "refactor.inline",
                "refactor.rewrite",
                "source",
                "source.organizeImports",
            },
        },
    },
}
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local lspflags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local servers = {
    'eslint',
    'tsserver',
    'cssls',
    'html',
    -- 'clangd',
}


for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lspflags,
    }
end

local neodev_ok, neodev = pcall(require, "neodev")
if neodev_ok then
    neodev.setup()
end

lspconfig['sumneko_lua'].setup ({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lspflags,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
            completion = {
                callSnippet = "Replace"
            }
        },
    },
})

if vim.fn.executable("clangd") then

    local ok_clang, clang_ex  = pcall(require, "clangd_extensions")

    if ok_clang then

        local clangd_capabilities = {
            textDocument = {
                completion = {
                    editsNearCursor = true,
                },
            },
            offsetEncoding = { 'utf-16' },
        }

        clang_ex.setup {
            server = {
                on_attach = on_attach,
                capabilities = vim.tbl_deep_extend('keep', capabilities, clangd_capabilities),
                cmd = {'clangd', '--header-insertion=never'},
            },
            extensions = {
                memory_usage = {
                    border = "rounded",
                },
                symbol_info = {
                    border = "rounded",
                },
            }
        }
    else
        lspconfig['clangd'].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = lspflags,
        }
    end
end


-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

-- Using Eslint to format on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = {"*.tsx", "*.ts", "*.jsx", "*.js"}, command = "EslintFixAll" })
