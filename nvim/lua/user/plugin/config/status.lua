local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
    return
end

local theme
local gruvbox_ok, gruvbox_groups = pcall(require, "gruvbox.groups")
if gruvbox_ok then
    theme = gruvbox_groups.setup()
end

local ViMode = {
    static = {
        map = {
            ['n']       = {'NORMAL',    theme.GruvboxGreen.fg   },
            ['no']      = {'O-PENDING', theme.GruvboxGreen.fg   },
            ['nov']     = {'O-PENDING', theme.GruvboxGreen.fg   },
            ['noV']     = {'O-PENDING', theme.GruvboxGreen.fg   },
            ['no\22']   = {'O-PENDING', theme.GruvboxGreen.fg   },
            ['niI']     = {'NORMAL',    theme.GruvboxGreen.fg   },
            ['niR']     = {'NORMAL',    theme.GruvboxGreen.fg   },
            ['niV']     = {'NORMAL',    theme.GruvboxGreen.fg   },
            ['nt']      = {'NORMAL',    theme.GruvboxGreen.fg   },
            ['ntT']     = {'NORMAL',    theme.GruvboxGreen.fg   },
            ['v']       = {'VISUAL',    theme.GruvboxOrange.fg  },
            ['vs']      = {'VISUAL',    theme.GruvboxOrange.fg  },
            ['V']       = {'V-LINE',    theme.GruvboxOrange.fg  },
            ['Vs']      = {'V-LINE',    theme.GruvboxOrange.fg  },
            ['\22']     = {'V-BLOCK',   theme.GruvboxOrange.fg  },
            ['\22s']    = {'V-BLOCK',   theme.GruvboxOrange.fg  },
            ['s']       = {'SELECT',    theme.GruvboxOrange.fg  },
            ['S']       = {'S-LINE',    theme.GruvboxOrange.fg  },
            ['\19']     = {'S-BLOCK',   theme.GruvboxOrange.fg  },
            ['i']       = {'INSERT',    theme.GruvboxBlue.fg    },
            ['ic']      = {'INSERT',    theme.GruvboxBlue.fg    },
            ['ix']      = {'INSERT',    theme.GruvboxBlue.fg    },
            ['R']       = {'REPLACE',   theme.GruvboxRed.fg     },
            ['Rc']      = {'REPLACE',   theme.GruvboxRed.fg     },
            ['Rx']      = {'REPLACE',   theme.GruvboxRed.fg     },
            ['Rv']      = {'V-REPLACE', theme.GruvboxOrange.fg  },
            ['Rvc']     = {'V-REPLACE', theme.GruvboxOrange.fg  },
            ['Rvx']     = {'V-REPLACE', theme.GruvboxOrange.fg  },
            ['c']       = {'COMMAND',   theme.GruvboxGreen.fg   },
            ['cv']      = {'EX',        theme.GruvboxGreen.fg   },
            ['ce']      = {'EX',        theme.GruvboxOrange.fg  },
            ['r']       = {'REPLACE',   theme.GruvboxOrange.fg  },
            ['rm']      = {'MORE',      theme.GruvboxOrange.fg  },
            ['r?']      = {'CONFIRM',   theme.GruvboxOrange.fg  },
            ['!']       = {'SHELL',     theme.GruvboxOrange.fg  },
            ['t']       = {'TERMINAL',  theme.GruvboxOrange.fg  },
        }
    },
    init = function(self)
        self.mode = vim.api.nvim_get_mode().mode
    end,
    provider = function(self)
        return " " .. self.map[self.mode][1] .." "
    end,
    hl = function(self)
        return { bg = self.map[self.mode][2], bold = true, fg = "#282828" }
    end,
}


local Navic
local navic_ok, navic = pcall(require, "nvim-navic")
if navic_ok then
    navic.setup {
        highlight = true,
    }
    Navic = {
        provider = function()
            return navic.get_location()
        end,
        enabled = function()
            return navic.is_available()
        end
    }

end



local TablineBufnr = {
    provider = function(self)
        return tostring(self.bufnr) .. ". "
    end,
    hl = "Comment",
}

-- we redefine the filename component, as we probably only want the tail and not the relative path

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}
local utils = require("heirline.utils")
local TablineFileName = {
    provider = function(self)
        -- self.filename will be defined later, just keep looking at the example!
        local filename = self.filename
        filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
        return filename
    end,
    hl = function(self)
        return { bold = self.is_active or self.is_visible, italic = true }
    end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
    {
        condition = function(self)
            return vim.api.nvim_buf_get_option(self.bufnr, "modified")
        end,
        provider = " ●",
        hl = { fg = theme.GruvboxGreen.fg },
    },
    {
        condition = function(self)
            return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
                or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
        end,
        provider = function(self)
            if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
                return "  "
            else
                return " "
            end
        end,
        hl = { fg = theme.GruvboxOrange.fg },
    },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
        if self.is_active then
            return "TabLineSel"
        else
            return "TabLine"
        end
    end,
    on_click = {
        callback = function(_, minwid, _, button)
            if (button == "m") then -- close on mouse middle click
                vim.api.nvim_buf_delete(minwid, {force = false})
            else
                vim.api.nvim_win_set_buf(0, minwid)
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
    },
    TablineBufnr,
    FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
    TablineFileName,
    TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
    condition = function(self)
        return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    { provider = " " },
    {
        provider = "",
        hl = { fg = "gray" },
        on_click = {
            callback = function(_, minwid)
                vim.api.nvim_buf_delete(minwid, { force = false })
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = "heirline_tabline_close_buffer_callback",
        },
    },
}

-- The final touch!
local TablineBufferBlock = utils.surround({ "", "" }, function(self)
    if self.is_active then
        return utils.get_highlight("TabLineSel").bg
    else
        return utils.get_highlight("TabLineSel").bg
    end
end, { TablineFileNameBlock, TablineCloseButton })

-- and here we go
local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
)
local Tabpage = {
    provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
    end,
    hl = function(self)
        if not self.is_active then
            return "TabLine"
        else
            return "TabLineSel"
        end
    end,
}

local TabpageClose = {
    provider = "%999X  %X",
    hl = "TabLine",
}

local TabPages = {
    -- only show this component if there's 2 or more tabpages
    condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = "%=" },
    utils.make_tablist(Tabpage),
    TabpageClose,
}
local TabLineOffset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        self.winid = win

        if vim.bo[bufnr].filetype == "NvimTree" then
            self.title = "NvimTree"
            return true
            -- elseif vim.bo[bufnr].filetype == "TagBar" then
            --     ...
        end
    end,

    provider = function(self)
        local title = self.title
        local width = vim.api.nvim_win_get_width(self.winid)
        local pad = math.ceil((width - #title) / 2)
        return string.rep(" ", pad) .. title .. string.rep(" ", pad)
    end,

    hl = function(self)
        if vim.api.nvim_get_current_win() == self.winid then
            return "TablineSel"
        else
            return "Tabline"
        end
    end,
}

local Align = { provider = "%=" }

local DefaultStatusline = {
    ViMode,
    Align,
    Align,
}

local DefaultWinbar = {
    Navic,
    Align,
    Align,
}

local StatusLines = {
    fallthrough = false,
    DefaultStatusline
}

local WinBars = {
    fallthrough = false,
    DefaultWinbar,
}
local TabLine = { TabLineOffset, BufferLine, TabPages }

heirline.setup(StatusLines, WinBars, TabLine)

-- Yep, with heirline we're driving manual!
vim.o.showtabline = 2
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
