local status_ok, feline= pcall(require, "feline")
if not status_ok then
    return
end

local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local navic = require("nvim-navic")

local force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
}
local Mode = {}

Mode.map = {
    ['n']       = 'NORMAL',
    ['no']      = 'O-PENDING',
    ['nov']     = 'O-PENDING',
    ['noV']     = 'O-PENDING',
    ['no\22']   = 'O-PENDING',
    ['niI']     = 'NORMAL',
    ['niR']     = 'NORMAL',
    ['niV']     = 'NORMAL',
    ['nt']      = 'NORMAL',
    ['ntT']     = 'NORMAL',
    ['v']       = 'VISUAL',
    ['vs']      = 'VISUAL',
    ['V']       = 'V-LINE',
    ['Vs']      = 'V-LINE',
    ['\22']     = 'V-BLOCK',
    ['\22s']    = 'V-BLOCK',
    ['s']       = 'SELECT',
    ['S']       = 'S-LINE',
    ['\19']     = 'S-BLOCK',
    ['i']       = 'INSERT',
    ['ic']      = 'INSERT',
    ['ix']      = 'INSERT',
    ['R']       = 'REPLACE',
    ['Rc']      = 'REPLACE',
    ['Rx']      = 'REPLACE',
    ['Rv']      = 'V-REPLACE',
    ['Rvc']     = 'V-REPLACE',
    ['Rvx']     = 'V-REPLACE',
    ['c']       = 'COMMAND',
    ['cv']      = 'EX',
    ['ce']      = 'EX',
    ['r']       = 'REPLACE',
    ['rm']      = 'MORE',
    ['r?']      = 'CONFIRM',
    ['!']       = 'SHELL',
    ['t']       = 'TERMINAL',
}

function Mode.get_mode()
    local mode_code = vim.api.nvim_get_mode().mode
    if Mode.map[mode_code] == nil then
        return mode_code
    end
    return Mode.map[mode_code]
end



local winbar_components = {
    active = {{}, {}, {}},
    inactive = {{}, {}, {}},
}

local components = {
    active = {{}, {}, {}},
    inactive = {{}, {}, {}},
}

local colors = require('gruvbox.palette')
local gruvbox = {
    bg          = colors.dark0,
    black       = colors.dark0,
    yellow      = colors.bright_yellow,
    cyan        = colors.bright_aqua,
    oceanblue   = colors.bright_blue,
    green       = colors.bright_green,
    orange      = colors.bright_orange,
    violet      = colors.bright_purple,
    magenta     = colors.neutral_purple,
    white       = colors.light0,
    fg          = colors.light1,
    skyblue     = colors.bright_blue,
    red         = colors.bright_red,
}

local vi_mode_colors = {
    NORMAL          = 'green',
    OP              = 'green',
    INSERT          = 'red',
    CONFIRM         = 'red',
    VISUAL          = 'skyblue',
    LINES           = 'skyblue',
    BLOCK           = 'skyblue',
    REPLACE         = 'violet',
    ['V-REPLACE']   = 'violet',
    ENTER           = 'cyan',
    MORE            = 'cyan',
    SELECT          = 'orange',
    COMMAND         = 'green',
    SHELL           = 'green',
    TERM            = 'green',
    NONE            = 'yellow'
}

local vi_mode_text = {
    NORMAL          = '<|',
    OP              = '<|',
    INSERT          = '|>',
    VISUAL          = '<>',
    LINES           = '<>',
    BLOCK           = '<>',
    REPLACE         = '<>',
    ['V-REPLACE']   = '<>',
    ENTER           = '<>',
    MORE            = '<>',
    SELECT          = '<>',
    COMMAND         = '<|',
    SHELL           = '<|',
    TERM            = '<|',
    NONE            = '<>',
    CONFIRM         = '|>'
}


force_inactive.filetypes = {
    'NvimTree',
    'dbui',
    'packer',
    'startify',
    'fugitive',
    'fugitiveblame'
}

force_inactive.buftypes = {
    'terminal'
}

-- STATUSLINE
-- LEFT

-- vi-mode
components.active[1][1] = {
    provider = function()
        local mode_code = vim.api.nvim_get_mode().mode
        if Mode.map[mode_code] == nil then
            return ' ' .. mode_code .. ' '
        end
        return ' ' .. Mode.map[mode_code] .. ' '
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
-- filename
components.active[1][3] = {
    provider = function()
        return vim.fn.expand("%:F")
    end,
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    }
}
-- MID

-- gitBranch
components.active[2][1] = {
    provider = 'git_branch',
    hl = {
        fg = 'violet',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffAdd
components.active[2][2] = {
    provider = 'git_diff_added',
    hl = {
        fg = 'green',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffModfified
components.active[2][3] = {
    provider = 'git_diff_changed',
    hl = {
        fg = 'orange',
        bg = 'bg',
        style = 'bold'
    }
}
-- diffRemove
components.active[2][4] = {
    provider = 'git_diff_removed',
    hl = {
        fg = 'red',
        bg = 'bg',
        style = 'bold'
    },
}

-- RIGHT

-- fileIcon
components.active[3][1] = {
    provider = function()
        local ok, devicons = pcall(require, 'nvim-web-devicons')
        if ok then
            local f_name, f_extension = vim.fn.expand('%:t'), vim.fn.expand('%:e')
            f_extension = f_extension ~= '' and f_extension or vim.bo.filetype
            local icon,_ = devicons.get_icon(f_name, f_extension)
            if icon == nil then
                icon = ''
            end
            return icon
        end
    end,
    hl = function()
        local val = {}
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
            val.fg = 'white'
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = ' '
}

-- fileType
components.active[3][2] = {
    provider = 'file_type',
    enabled = function()
        local file =vim.fn.expand('%:p')
        if file == nil or #file == 0 then
            return false
        end
        local size = vim.fn.getfsize(file)
        return size > 0
    end,
    hl = function()
        local val = {}
        local filename = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
            val.fg = 'white'
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = ' '
}
-- fileSize
components.active[3][3] = {
    provider = 'file_size',
    enabled = function()
        local file =vim.fn.expand('%:p')
        if file == nil or #file == 0 then
            return false
        end
        local size = vim.fn.getfsize(file)
        return size > 0
    end,
    hl = {
        fg = 'skyblue',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}

-- fileEncode
components.active[3][4] = {
    provider = 'file_encoding',
    enabled = function()
        local file =vim.fn.expand('%:p')
        if file == nil or #file == 0 then
            return false
        end
        local size = vim.fn.getfsize(file)
        return size > 0
    end,
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
components.active[3][5] = {
    provider = 'position',
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- linePercent
components.active[3][6] = {
    provider = 'line_percentage',
    hl = {
        fg = 'white',
        bg = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- scrollBar
components.active[3][7] = {
    provider = 'scroll_bar',
    hl = {
        fg = 'yellow',
        bg = 'bg',
    },
}

-- INACTIVE

-- fileType
components.inactive[1][1] = {
    provider = function()
        return vim.fn.expand("%:F")
    end,
}

-- WINBAR
-- LEFT

-- nvimGps
winbar_components.active[1][1] = {
    provider = function()
        return navic.get_location()
    end,
    enabled = function()
        return navic.is_available()
    end
}

-- MID

-- RIGHT

-- LspName
winbar_components.active[3][1] = {
    provider = 'lsp_client_names',
    hl = {
        fg = 'yellow',
        style = 'bold'
    },
    right_sep = ' '
}
-- diagnosticErrors
winbar_components.active[3][2] = {
    provider = 'diagnostic_errors',
    enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
    hl = {
        fg = 'red',
        style = 'bold'
    }
}
-- diagnosticWarn
winbar_components.active[3][3] = {
    provider = 'diagnostic_warnings',
    enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
    hl = {
        fg = 'yellow',
        style = 'bold'
    }
}
-- diagnosticHint
winbar_components.active[3][4] = {
    provider = 'diagnostic_hints',
    enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
    hl = {
        fg = 'cyan',
        style = 'bold'
    }
}
-- diagnosticInfo
winbar_components.active[3][5] = {
    provider = 'diagnostic_info',
    enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
    hl = {
        fg = 'skyblue',
        style = 'bold'
    }
}

-- INACTIVE

-- fileType
winbar_components.inactive[1][1] = {
    provider = 'file_type',
}

feline.setup({
    theme = gruvbox,
    vi_mode_colors = vi_mode_colors,
    components = components,
    force_inactive = force_inactive,
})

require('feline').winbar.setup({
    components = winbar_components,
    force_inactive = force_inactive,
})
