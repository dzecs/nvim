-- Cattppucin theme

local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

catppuccin.setup({
	styles = {
		comments = "NONE",
		functions = "bold",
		keywords = "NONE",
		strings = "NONE",
		variables = "NONE",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = "NONE",
				hints = "NONE",
				warnings = "NONE",
				information = "NONE",
			},
		},
	},
})
