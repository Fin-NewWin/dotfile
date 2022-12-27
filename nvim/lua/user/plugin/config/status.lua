local M = {}

function M.config()
    local status_ok, heirline = pcall(require, "heirline")
    if not status_ok then
        return
    end

    local theme
    local gruvbox_ok, gruvbox_groups = pcall(require, "gruvbox.groups")
    if gruvbox_ok then
        theme = gruvbox_groups.setup()
    end

    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local fn = vim.fn


    local ViMode = {
        static = {
            map = {
                ["n"]     = { "NORMAL", theme.GruvboxGreen.fg },
                ["no"]    = { "O-PENDING", theme.GruvboxGreen.fg },
                ["nov"]   = { "O-PENDING", theme.GruvboxGreen.fg },
                ["noV"]   = { "O-PENDING", theme.GruvboxGreen.fg },
                ["no\22"] = { "O-PENDING", theme.GruvboxGreen.fg },
                ["niI"]   = { "NORMAL", theme.GruvboxGreen.fg },
                ["niR"]   = { "NORMAL", theme.GruvboxGreen.fg },
                ["niV"]   = { "NORMAL", theme.GruvboxGreen.fg },
                ["nt"]    = { "NORMAL", theme.GruvboxGreen.fg },
                ["ntT"]   = { "NORMAL", theme.GruvboxGreen.fg },
                ["v"]     = { "VISUAL", theme.GruvboxOrange.fg },
                ["vs"]    = { "VISUAL", theme.GruvboxOrange.fg },
                ["V"]     = { "V-LINE", theme.GruvboxOrange.fg },
                ["Vs"]    = { "V-LINE", theme.GruvboxOrange.fg },
                ["\22"]   = { "V-BLOCK", theme.GruvboxOrange.fg },
                ["\22s"]  = { "V-BLOCK", theme.GruvboxOrange.fg },
                ["s"]     = { "SELECT", theme.GruvboxOrange.fg },
                ["S"]     = { "S-LINE", theme.GruvboxOrange.fg },
                ["\19"]   = { "S-BLOCK", theme.GruvboxOrange.fg },
                ["i"]     = { "INSERT", theme.GruvboxBlue.fg },
                ["ic"]    = { "INSERT", theme.GruvboxBlue.fg },
                ["ix"]    = { "INSERT", theme.GruvboxBlue.fg },
                ["R"]     = { "REPLACE", theme.GruvboxRed.fg },
                ["Rc"]    = { "REPLACE", theme.GruvboxRed.fg },
                ["Rx"]    = { "REPLACE", theme.GruvboxRed.fg },
                ["Rv"]    = { "V-REPLACE", theme.GruvboxOrange.fg },
                ["Rvc"]   = { "V-REPLACE", theme.GruvboxOrange.fg },
                ["Rvx"]   = { "V-REPLACE", theme.GruvboxOrange.fg },
                ["c"]     = { "COMMAND", theme.GruvboxGreen.fg },
                ["cv"]    = { "EX", theme.GruvboxGreen.fg },
                ["ce"]    = { "EX", theme.GruvboxOrange.fg },
                ["r"]     = { "REPLACE", theme.GruvboxOrange.fg },
                ["rm"]    = { "MORE", theme.GruvboxOrange.fg },
                ["r?"]    = { "CONFIRM", theme.GruvboxOrange.fg },
                ["!"]     = { "SHELL", theme.GruvboxOrange.fg },
                ["t"]     = { "TERMINAL", theme.GruvboxOrange.fg },
            }
        },
        init = function(self)
            self.mode = vim.api.nvim_get_mode().mode
        end,
        provider = function(self)
            return " " .. self.map[self.mode][1] .. " "
        end,
        hl = function(self)
            return { bg = self.map[self.mode][2], bold = true, fg = "#282828" }
        end,
    }


    local GitBranch = {
        condition = conditions.is_git_repo,
        init = function(self)
            self.status_dict = vim.b.gitsigns_status_dict
            self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
                self.status_dict.changed ~= 0
        end,
        { -- git branch name
            provider = function(self)
                return "   " .. self.status_dict.head
            end,
            hl = {fg = theme.GruvboxPurple.fg},
        },
        {
            provider = function(self)
                if self.has_changes then
                    return " ("
                end
            end,
            hl = { fg = theme.GruvboxPurple.fg},
        },
        {
            provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and ("+" .. count)
            end,
            hl = { fg = theme.GruvboxGreen.fg},
        },
        {
            provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and ("-" .. count)
            end,
            hl = { fg = theme.GruvboxRed.fg},
        },
        {
            provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and ("~" .. count)
            end,
            hl = { fg = theme.GruvboxOrange.fg},
        },
        {
            provider = function(self)
                if self.has_changes then
                    return ")"
                end
            end,
            hl = { fg = theme.GruvboxPurple.fg},
        },
        {
            provider = function(self)
                return "  "
            end,
        },
        hl = { bg = theme.GruvboxBg1.fg, bold = true},
    }


    -- -- TODO: recording macro
    -- local ShowMacroRecording = function()
    --     local recording_register = vim.fn.reg_recording()
    --     if recording_register == "" then
    --         return ""
    --     else
    --         return " Recording @" .. recording_register .. " "
    --     end
    -- end

    local SearchResults = {
        condition = function(self)
            local query = fn.getreg("/")
            if query == "" then return end

            if query:find("@") then return end

            local search_count = fn.searchcount({ recompute = 1, maxcount = -1 })
            local active = false
            if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
                active = true
            end
            if not active then return end

            query = query:gsub([[^\V]], "")
            query = query:gsub([[\<]], ""):gsub([[\>]], "")

            self.query = query
            self.count = search_count
            return true
        end,
        {
            provider = function(self)
                return table.concat {
                    " [", self.count.current, "/", self.count.total, "] "
                }
            end,
            hl = { fg = theme.GruvboxFg0.fg },
        },
    }

    local LSPActive = {
        condition = conditions.lsp_attached,
        update    = { "LspAttach", "LspDetach" },
        provider  = function()
            local names = {}
            for i, server in pairs(vim.lsp.buf_get_clients(0)) do
                table.insert(names, server.name)
            end
            return "  [" .. table.concat(names, " ") .. "] "
        end,
        hl = {
            fg = theme.GruvboxYellow.fg,
            bg = theme.GruvboxBg1.fg,
            bold = true
        },
    }
    local Diagnostics = {
        condition = conditions.has_diagnostics,
        static = {
            error_icon = " ",
            warn_icon  = " ",
            hint_icon  = " ",
            info_icon  = " ",
        },
        init = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,
        update = { "DiagnosticChanged", "BufEnter" },
        {
            provider = function(self)
                return "  "
            end,
            hl = { bg = "NONE" }
        },
        {
            provider = function(self)
                return self.errors > 0 and (self.error_icon .. self.errors .. " ")
            end,
            hl = {
                fg = "#fb4934",
                bold = true,
            },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
            end,
            hl = {
                fg = "#fabd2f",
                bold = true,
            },
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. " ")
            end,
            hl = {
                fg = "#83a598",
                bold = true,
            },
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints)
            end,
            hl = {
                fg = "#8ec07c",
                bold = true,
            },
        },
    }


    local Ruler = {
        provider = " %l:%2c ",
        hl = { fg = theme.GruvboxFg0.fg, bold = true }
    }

    --------------------------------------------------------------------------------


    local Align = {
        provider = "%=",
        hl = { bg = "NONE" }
    }

    local Space = {
        provider = ' ',
        hl = { bg = "NONE" }
    }

    local DefaultStatusline = {
        ViMode,
        GitBranch,
        Diagnostics,
        Align,
        SearchResults,
        Align,
        Ruler,
    }

    local StatusLines = {
        fallthrough = false,
        DefaultStatusline
    }

    heirline.setup(StatusLines)

    -- Yep, with heirline we're driving manual!
    -- vim.o.showtabline = 2
    vim.cmd([[au FileType * if index(["wipe", "delete"], &bufhidden) >= 0 | set nobuflisted | endif]])

    vim.api.nvim_create_augroup("Heirline", { clear = true })
end

return M
