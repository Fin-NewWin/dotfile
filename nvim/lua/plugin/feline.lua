local status_ok, feline = pcall(require, "feline")
if not status_ok then
    return
end

vim.opt.laststatus = 3

local lsp = require('feline.providers.lsp')

local function lsp_diag(name)
    return string.format('lsp.diagnostics_exist(vim.diagnostic.severity.%s)', name)
end

local vi_mode_utils = require('feline.providers.vi_mode')

local force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
}

local components = {
    active = {{}, {}, {}},
    inactive = {{}, {}, {}},
}

local colors = {
    bg = '#282828',
    fg = '#ebdbb2',
    black = '#282828',
    yellow = '#fabd2f',
    cyan = '#8ec07c',
    oceanblue = '#83a598',
    green = '#babb26',
    orange = '#fe8019',
    violet = '#d3869b',
    magenta = '#b16286',
    white = '#a89984',
    skyblue = '#458588',
    red = '#fb4934',
}

local vi_mode_colors = {
    NORMAL = 'green',
    OP = 'green',
    INSERT = 'red',
    CONFIRM = 'red',
    VISUAL = 'skyblue',
    LINES = 'skyblue',
    BLOCK = 'skyblue',
    REPLACE = 'violet',
    ['V-REPLACE'] = 'violet',
    ENTER = 'cyan',
    MORE = 'cyan',
    SELECT = 'orange',
    COMMAND = 'green',
    SHELL = 'green',
    TERM = 'green',
    NONE = 'yellow'
}

local vi_mode_text = {
    NORMAL = '<|',
    OP = '<|',
    INSERT = '|>',
    VISUAL = '<>',
    LINES = '<>',
    BLOCK = '<>',
    REPLACE = '<>',
    ['V-REPLACE'] = '<>',
    ENTER = '<>',
    MORE = '<>',
    SELECT = '<>',
    COMMAND = '<|',
    SHELL = '<|',
    TERM = '<|',
    NONE = '<>',
    CONFIRM = '|>'
}

force_inactive.filetypes = {
    'NvimTree',
    'dbui',
    'packer',
    'startify',
    'fugitive',
    'fugitiveblame',
    'checkhealth',
}

force_inactive.buftypes = {
    'terminal',
}

-- LEFT
components.active[1][1] = {
    provider = function()
        return ' ' .. vi_mode_utils.get_vim_mode() .. ' '
    end,
    hl = function()
        local val = {}
        val.bg = vi_mode_utils.get_mode_color()
        val.fg = 'black'
        val.style = 'bold'
        return val
    end,
    right_sep = ' '
}
-- vi-symbol
components.active[1][2] = {
    provider = function()
        return vi_mode_text[vi_mode_utils.get_vim_mode()]
    end,
    hl = function()
        local val = {}
        val.fg = vi_mode_utils.get_mode_color()
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = ' '
}
-- gitBranch
components.active[1][3] = {
    provider = 'git_branch',
    hl = {
        fg = 'violet',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffAdd
components.active[1][4] = {
    provider = 'git_diff_added',
    hl = {
        fg = 'green',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffModfified
components.active[1][5] = {
    provider = 'git_diff_changed',
    hl = {
        fg = 'orange',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffRemove
components.active[1][6] = {
    provider = 'git_diff_removed',
    hl = {
        fg = 'red',
        bg = 'bg',
        style = 'bold'
    },
}

-- filename
components.active[1][7] = {
    provider = function()
        return vim.fn.expand("%:F")
    end,
    hl = {
        fg = 'fg',
        bg = 'bg',
        style = 'bold'
    },
    -- right_sep = {
    --     str = ' > ',
    --     hl = {
    --         fg = 'white',
    --         bg = 'bg',
    --         style = 'bold'
    --     },
    --     enabled = function() return 1 > 0 end,
    -- },
    left_sep = function()
        if vim.b.gitsigns_status ~= nil
        then
            return ' '
        end
        return ''
    end
}

-- RIGHT

-- LspName
components.active[3][1] = {
    provider = 'lsp_client_names',
    hl = {
        fg = 'orange',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = '',
}

-- diagnosticErrors
components.active[3][2] = {
    provider = 'diagnostic_errors',
    enabled = function() return lsp_diag(ERROR) end,
    hl = {
        fg = 'red',
        style = 'bold'
    }
}

-- diagnosticWarn
components.active[3][3] = {
    provider = 'diagnostic_warnings',
    enabled = function() return lsp_diag(WARN) end,
    hl = {
        fg = 'yellow',
        style = 'bold'
    }
}

-- diagnosticHint
components.active[3][4] = {
    provider = 'diagnostic_hints',
    enabled = function() return lsp_diag(HINT) end,
    hl = {
        fg = 'cyan',
        style = 'bold'
    }
}
-- diagnosticInfo
components.active[3][5] = {
    provider = 'diagnostic_info',
    enabled = function() return lsp_diag(INFO) end,
    hl = {
        fg = 'skyblue',
        style = 'bold'
    }
}

-- fileIcon
components.active[3][6] = {
    provider = function()
        local filetype = vim.bo.filetype
        local extension = vim.fn.expand('%:e')
        local icon,_  = require'nvim-web-devicons'.get_icon_by_filetype(filetype, extension)
        if icon == nil then
            icon = ''
        end
        return icon
    end,
    hl = function()
        local val = {}
        local filetype = vim.bo.filetype
        local extension = vim.fn.expand('%:e')
        local icon, color  = require'nvim-web-devicons'.get_icon_colors_by_filetype(filetype, extension)
        val.fg = 'white'
        if icon ~= nil then
            val.fg = color
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    left_sep = ' ',
}
-- fileType
components.active[3][7] = {
    provider = 'file_type',
    hl = function()
        local val = {}
        local filetype = vim.bo.filetype
        local extension = vim.fn.expand('%:e')
        local icon, color  = require'nvim-web-devicons'.get_icon_colors_by_filetype(filetype, extension)
        val.fg = 'white'
        if icon ~= nil then
            val.fg = color
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    left_sep = ' ',
    right_sep = ' '
}
-- fileSize
components.active[3][8] = {
    provider = 'file_size',
    enabled = function() return vim.fn.wordcount().bytes > 0 end,
    hl = {
        fg = 'skyblue',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- lineInfo
components.active[3][9] = {
    provider = 'position',
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- linePercent
components.active[3][10] = {
    provider = 'line_percentage',
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- scrollBar
components.active[3][11] = {
    provider = 'scroll_bar',
    hl = {
        fg = 'yellow',
        bg = 'bg',
    },
}

-- INACTIVE
-- fileType
components.inactive[1][1] = {
    provider = 'file_type',
    hl = {
        fg = 'black',
        bg = 'cyan',
        style = 'bold'
    },
    left_sep = {
        str = ' ',
        hl = {
            fg = 'NONE',
            bg = 'cyan'
        }
    },
    right_sep = {
        {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'cyan'
            }
        },
        ' '
    }
}

feline.setup({
    theme = colors,
    default_bg = bg,
    default_fg = fg,
    vi_mode_colors = vi_mode_colors,
    components = components,
    force_inactive = force_inactive,
})


