local status_ok, hop = pcall(require, "hop")
if not status_ok then
    return
end


hop.setup { keys = 'etovxqpdygfblzhckisuran' }

-- local key = vim.api.nvim_set_keymap
local keyset = vim.keymap.set
local opt = { noremap = true }
local directions = require('hop.hint').HintDirection

keyset('', 'f', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, opt)
keyset('', 'F', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, opt)
keyset('', 't', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
keyset('', 'T', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})
