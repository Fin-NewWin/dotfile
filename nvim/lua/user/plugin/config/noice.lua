local ok, noice = pcall(require, "noice")
if not ok then
    return
end

noice.setup {

    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },

        progress = {
            enabled = false,
        }
    },

    -- cmdline = {
    --     view = "cmdline",
    -- },

    presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
    },

    routes = {
        {
            filter = {
                event = "msg_show",
                kind = "search_count",
            },
            opts = { skip = true },
        },
    },

}
