-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup({
	options = {
		theme = "catppuccin",
		component_separators = "|",
	},
	sections = {
		lualine_b = { "filename", "branch" },
		lualine_c = { "fileformat" },
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})
