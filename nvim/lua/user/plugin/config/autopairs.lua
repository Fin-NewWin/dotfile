local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = { "TelescopePrompt" , "spectre_panel", "vim" },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
    enable_check_bracket_line = false,
})

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

local npairs_rule = require("nvim-autopairs.rule")
local ts_conds = require("nvim-autopairs.ts-conds")

-- lua
npairs.add_rules({
    npairs_rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({ "string", "comment" })),
    npairs_rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({ "function" }))
})

-- Add spaces between parentheses
npairs.add_rules {
    npairs_rule(' ', ' ')
    :with_pair(function (opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
    npairs_rule('( ', ' )')
    :with_pair(function() return false end)
    :with_move(function(opts)
        return opts.prev_char:match('.%)') ~= nil
    end)
    :use_key(')'),
    npairs_rule('{ ', ' }')
    :with_pair(function() return false end)
    :with_move(function(opts)
        return opts.prev_char:match('.%}') ~= nil
    end)
    :use_key('}'),
    npairs_rule('[ ', ' ]')
    :with_pair(function() return false end)
    :with_move(function(opts)
        return opts.prev_char:match('.%]') ~= nil
    end)
    :use_key(']')
}
