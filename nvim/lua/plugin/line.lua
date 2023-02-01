return {
    {
        "rebelot/heirline.nvim",
        event = "VeryLazy",
        dependencies = {
            "SmiteshP/nvim-navic",
        },
        config = function()
            local heirline = require("heirline")

            local theme = require("gruvbox.groups").setup()

            local conditions = require("heirline.conditions")
            local utils = require("heirline.utils")

            local fn = vim.fn

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
                    hl = { fg = theme.GruvboxPurple.fg },
                },
                {
                    provider = function(self)
                        if self.has_changes then
                            return " ("
                        end
                    end,
                    hl = { fg = theme.GruvboxPurple.fg },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.added or 0
                        return count > 0 and ("+" .. count)
                    end,
                    hl = { fg = theme.GruvboxGreen.fg },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.removed or 0
                        return count > 0 and ("-" .. count)
                    end,
                    hl = { fg = theme.GruvboxRed.fg },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.changed or 0
                        return count > 0 and ("~" .. count)
                    end,
                    hl = { fg = theme.GruvboxOrange.fg },
                },
                {
                    provider = function(self)
                        if self.has_changes then
                            return ")"
                        end
                    end,
                    hl = { fg = theme.GruvboxPurple.fg },
                },
                {
                    provider = function(self)
                        return "  "
                    end,
                },
                hl = {
                    bg = theme.GruvboxBg1.fg,
                    -- bold = true,
                },
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
                    return "   [LSP]  "
                end,
                hl        = {
                    fg = theme.GruvboxYellow.fg,
                    bg = theme.GruvboxBg1.fg,
                    -- bold = true
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
                        return self.errors > 0 and (self.error_icon .. self.errors .. " ")
                    end,
                    hl = {
                        fg = "#fb4934",
                        -- bold = true,
                    },
                },
                {
                    provider = function(self)
                        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
                    end,
                    hl = {
                        fg = "#fabd2f",
                        -- bold = true,
                    },
                },
                {
                    provider = function(self)
                        return self.info > 0 and (self.info_icon .. self.info .. " ")
                    end,
                    hl = {
                        fg = "#83a598",
                        -- bold = true,
                    },
                },
                {
                    provider = function(self)
                        return self.hints > 0 and (self.hint_icon .. self.hints)
                    end,
                    hl = {
                        fg = "#8ec07c",
                        -- bold = true,
                    },
                },
                {
                    provider = function(self)
                        return "  "
                    end,
                },
                hl = {
                    -- fg = theme.GruvboxYellow.fg,
                    bg = theme.GruvboxBg1.fg,
                    -- bold = true
                },
            }


            local Ruler = {
                -- provider = " %l:%2c ",
                provider = " %3l/%L祈%3c "
                -- hl = { fg = theme.GruvboxFg0.fg, bold = true }
            }

            -- Winbar

            local FileNameBlock = {
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
            }

            local FileName = {
                init = function(self)
                    local file = self.filename
                    local extension = vim.fn.fnamemodify(file, ":e")

                    self.work_dir = vim.fn.fnamemodify(file, ":.:h")

                    self.current_file = vim.fn.fnamemodify(file, ":t")

                    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(file, extension,
                        { default = true })

                end,
                {
                    provider = function(self)
                        local work_dir = self.work_dir
                        if self.current_file == "" or work_dir == "." then return end

                        if work_dir:sub(1, 1) == '/' then
                            work_dir = work_dir:sub(2)
                        end

                        work_dir = work_dir:gsub("/", " > ")

                        return work_dir .. " > "
                    end,
                },
                {
                    provider = function(self)
                        return self.icon .. " "
                    end,
                    hl = function(self)
                        return { fg = self.icon_color }
                    end
                },
                {
                    provider = function(self)
                        local cf = self.current_file
                        if cf == "" then
                            return "[No Name]"
                        end
                        return cf
                    end
                }
            }

            FileNameBlock = utils.insert(
                FileNameBlock,
                FileName,
                { provider = '%<' }
            )

            local Navic = {}
            local navic_ok, navic = pcall(require, "nvim-navic")
            if navic_ok then
                navic.setup {
                    highlight = true,
                    navic.setup {
                        icons = {
                            File = ' ',
                            Module = ' ',
                            Namespace = ' ',
                            Package = ' ',
                            Class = ' ',
                            Method = ' ',
                            Property = ' ',
                            Field = ' ',
                            Constructor = ' ',
                            Enum = ' ',
                            Interface = ' ',
                            Function = ' ',
                            Variable = ' ',
                            Constant = ' ',
                            String = ' ',
                            Number = ' ',
                            Boolean = ' ',
                            Array = ' ',
                            Object = ' ',
                            Key = ' ',
                            Null = ' ',
                            EnumMember = ' ',
                            Struct = ' ',
                            Event = ' ',
                            Operator = ' ',
                            TypeParameter = ' '
                        }
                    }
                }
                Navic = {
                    provider = function()
                        if navic.is_available() then
                            if navic.get_location() == "" then
                                return ""
                            end
                            return "> " .. navic.get_location()
                        end
                        return ""
                    end,
                    update = "CursorMoved"
                }
            else
                vim.notify("Navic not in path", 4, { title = "Plugin Error" })
            end

            local Align = {
                provider = "%=",
                hl = { bg = "NONE" }
            }

            local Space = {
                provider = ' ',
                hl = { bg = "NONE" }
            }

            local DefaultStatusline = {
                GitBranch,
                Align,
                LSPActive,
                Diagnostics,
                Align,
                SearchResults,
                Ruler,
            }

            local DefaultWinbar = {
                -- LSPActive,
                FileNameBlock,
                Space,
                Navic,
                -- Align,
            }

            local StatusLines = {
                fallthrough = false,
                DefaultStatusline
            }

            local WinBars = {
                fallthrough = false,
                { -- Hide the winbar for special buffers
                    condition = function()
                        return conditions.buffer_matches({
                            buftype = { "nofile", "prompt", "help", "quickfix" },
                            filetype = { "^git.*", "fugitive" },
                        })
                    end,
                    init = function()
                        vim.opt_local.winbar = nil
                    end
                },
                { -- An inactive winbar for regular files
                    condition = function()
                        return not conditions.is_active()
                    end,
                    FileNameBlock
                },
                DefaultWinbar,
            }

            heirline.setup({
                statusline = StatusLines,
                winbar = WinBars,
            })

            -- Yep, with heirline we're driving manual!
            vim.cmd([[au FileType * if index(["wipe", "delete"], &bufhidden) >= 0 | set nobuflisted | endif]])
            vim.api.nvim_create_autocmd("User", {
                pattern = 'HeirlineInitWinbar',
                callback = function(args)
                    local buf = args.buf
                    local buftype = vim.tbl_contains(
                        { "prompt", "nofile", "help", "quickfix" },
                        vim.bo[buf].buftype
                    )
                    local filetype = vim.tbl_contains({ "gitcommit", "fugitive" }, vim.bo[buf].filetype)
                    if buftype or filetype then
                        vim.opt_local.winbar = nil
                    end
                end,
            })
        end
    },
}
