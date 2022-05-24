local onedark_status_ok, onedark = pcall(require, "onedark")
if not onedark_status_ok then
	return
end
--- Lua
onedark.setup({
	function_style = "NONE",
	comment_style = "NONE",
	msg_area_style = "NONE",
	variable_style = "NONE",
	keyword_style = "NONE",
})

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
