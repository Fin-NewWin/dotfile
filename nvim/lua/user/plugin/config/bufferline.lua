local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup({
    options = {
        -- separator_style = "thick",
        offsets = {
            { filetype = "NvimTree", text = "", padding = 1 },
            { filetype = "neo-tree", text = "", padding = 1 },
            { filetype = "Outline", text = "", padding = 1 },
        },
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
    }
})
