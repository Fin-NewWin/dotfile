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

local signs = {
    Error   =   "",
    Warn    =   "",
    Hint    =   "",
    Info    =   "",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config = {
    virtual_text = true,
    signs = {
        active = signs,
    },
    update_in_insert = true,
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

local lspsaga_ok,_ = pcall(require, "lspsaga")

local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
    local default_opts = _default_opts(options)
    default_opts.border = 'rounded'
    return default_opts
end

-- Pipe commands into telescope
vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local key = vim.keymap.set
local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    if lspsaga_ok then
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        key("n", "gh", "<cmd>Lspsaga lsp_finderCR>", bufopts)
        key({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts)
        key("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", bufopts)
        key("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts)
        key("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", bufopts)
        key("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", bufopts)
        key("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
        key("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
        key("n", "[D", function()
            require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end, bufopts)
        key("n", "]E", function()
            require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
        end, bufopts)
        key("n","<leader>o", "<cmd>LSoutlineToggle<CR>",bufopts)
        key("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
        -- key("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", bufopts)
        -- key("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", bufopts)
        -- key("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], bufopts)
        key('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    else
        key('n', 'gD', vim.lsp.buf.declaration, bufopts)
        key('n', 'gd', vim.lsp.buf.definition, bufopts)
        key('n', 'K', vim.lsp.buf.hover, bufopts)
        key('n', 'gi', vim.lsp.buf.implementation, bufopts)
        key('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        key('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        key('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        key('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        key('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        key('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        key('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        key('n', 'gr', vim.lsp.buf.references, bufopts)
        key('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

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
    'tsserver',
}


for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lspflags,
    }
end

local neodev_ok, neodev = pcall(require, "neodev")
if not neodev_ok then
    return
end

neodev.setup()
lspconfig.sumneko_lua.setup ({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lspflags,
    settings = {
        Lua = {
            type = {
                -- weakUnionCheck = true,
                -- weakNilCheck = true,
                -- castNumberToInteger = true,
            },
            format = {
                enable = false,
            },
            hint = {
                enable = true,
                arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                await = true,
                paramName = "Disable", -- "All", "Literal", "Disable"
                paramType = false,
                semicolon = "Disable", -- "All", "SameLine", "Disable"
                setType = true,
            },
            -- spell = {"the"}
            runtime = {
                version = "LuaJIT",
                special = {
                    reload = "require",
                },
            },
            diagnostics = {
                globals = { "vim" },
                unusedLocalExclude = { "_*" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true,
                    -- [vim.fn.datapath "config" .. "/lua"] = true,
                },
            },
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace"
            }
        },
    },
})
