local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local function min_window_width(width)
  return function() return vim.fn.winwidth(0) > width end
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
            {'branch', cond = min_window_width(120) },
            { 'diff', source = diff_source },
            "diagnostics",
        },
		lualine_c = {
            "filename"
        },
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
