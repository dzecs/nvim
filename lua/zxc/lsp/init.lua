local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("zxc.lsp.lsp-installer")
require("zxc.lsp.handlers").setup()
require("zxc.lsp.null-ls")

-- init.lua
require("lspconfig").jdtls.setup({ cmd = { "jdtls" } })
