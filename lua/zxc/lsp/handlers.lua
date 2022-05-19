local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = true,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_keymaps()
	local opts = { noremap = true, silent = true, buffer = 0 }
	local keymap = vim.keymap.set
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "gT", vim.lsp.buf.type_definition, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "<leader>dj", vim.diagnostic.goto_next, opts)
	keymap("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
	keymap("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
	keymap("n", "<leader>r", vim.lsp.buf.rename, opts)

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({bufnr = bufnr})' ]])
end

-- Formatting on save null-ls

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

M.on_attach = function(client, bufnr)

	-- Avoid conflict on formatting
	local lsp_formatting = function()
		vim.lsp.buf.format({
			filter = function(clients)
				-- filter out clients that you don't want to use
				return vim.tbl_filter(function()
					return client.name ~= "tsserver" or "sumneko_lua"
				end, clients)
			end,
			bufnr = bufnr,
		})
	end

	-- add to your shared on_attach callback
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting()
			end,
		})
	end

	if client.name == "tsserver" then
		local config = {
			virtual_text = false,
		}
		vim.diagnostic.config(config)
	end
	lsp_keymaps()
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
