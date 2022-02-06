-- Cattppucin theme

local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
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
