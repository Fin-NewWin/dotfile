-- See `:help vim.lsp.*` for documentation on any of the below functions
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Border Hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with( vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with( vim.lsp.handlers.signature_help, { border = "single" })

local signs = {
    Error   =   "",
    Warn    =   "",
    Hint    =   "",
    Info    =   "",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

local config = {
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
        border = "single",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)

local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
    local default_opts = _default_opts(options)
    default_opts.border = 'single'
    return default_opts
end

-- Pipe commands into telescope
vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.colorProvider = true

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
    'jedi_language_server',
    'clangd',
    'tsserver',
    'emmet_ls',
}
for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }
end


local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/";
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand("$VIMRUNTIME/lua")] = true

    -- TODO: Figure out how to get these to work...
    --  Maybe we need to ship these instead of putting them in `src`?...
    result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

    return result;
end

lspconfig.sumneko_lua.setup ({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",

            },
            completion = {
                keywordSnippet = "Disable",
                showWord = "Disable",
            },
            diagnostics = {
                enable = true,
                disable = config.disabled_diagnostics or {
                    "trailing-space",
                    "unused-local",
                },
                globals = vim.list_extend({
                    "vim",
                    "describe", "it", "before_each", "after_each", "teardown", "pending", "clear",
                },
                config.globals or {}),
            },
            workspace = {
                library = vim.list_extend(get_lua_runtime(), config.library or {}),
                maxPreload = 10000,
                preloadFileSize = 10000,
            },
            telemetry = { enable = false, },
        },
    },
})

-- nvim-cmp setup
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()
local lspkind = require('lspkind')


cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
    },
    formatting = {
        fields = {'kind', 'abbr', 'menu'},
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s", lspkind.presets.default[vim_item.kind])
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                ultisnips = "[UltiSnips]",
                nvim_lua = "[Lua]",
                cmp_tabnine = "[TabNine]",
                look = "[Look]",
                path = "[Path]",
                spell = "[Spell]",
                calc = "[Calc]",
                emoji = "[Emoji]"
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
}

local fidget_status_ok, fidget = pcall(require, "fidget")
if not fidget_status_ok then
    return
end

fidget.setup{}
