-- Theme

local colorscheme = "catppuccin"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

-- Nvim colorizer
local colorizer_status_ok, colorizer = pcall(require, "colorizer")
if not colorizer_status_ok then
	return
end

colorizer.setup({
	"css",
	"javascript",
	css = { css = true },
})
-- Cattppucin theme
--
local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
	return
end

catppuccin.setup({
	styles = {
		comments = "NONE",
		functions = "NONE",
		keywords = "NONE",
		strings = "NONE",
		variables = "NONE",
	},
})
