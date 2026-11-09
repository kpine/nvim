-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gd", function()
	require("mini.extra").pickers.lsp({ scope = "definition" })
end, { desc = "Go to definition" })
vim.keymap.set("n", "grr", function()
	require("mini.extra").pickers.lsp({ scope = "references" })
end, { desc = "Go to references" })

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" },
			procMacro = { enable = true },
			cargo = {
				buildScripts = { enable = true },
			},
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
})
