local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
    return
end
local theme = require("gruvbox.groups").setup()

-- stylua: ignore
local map = {
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

local ViMode = {
    init = function(self)
        self.mode = vim.api.nvim_get_mode().mode
    end,
    provider = function(self)
        return " " .. map[self.mode][1] .." "
    end,
    hl = function(self)
        return { bg = map[self.mode][2], bold = true, fg = "#282828" }
    end,
}

local DefaultStatusline = {
    ViMode,
}
local Align = { provider = "%=" }
local StatusLines = {
    fallthrough = false,

    DefaultStatusline, Align,
    Align,
}

heirline.setup(StatusLines)
