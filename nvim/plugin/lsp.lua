-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gd", function()
	require("mini.extra").pickers.lsp({ scope = "definition" })
end, { desc = "Go to definition" })
vim.keymap.set("n", "grr", function()
	require("mini.extra").pickers.lsp({ scope = "references" })
end, { desc = "Go to references" })

vim.diagnostic.config({ virtual_text = true })

-- Neovim merges these on top of vim.lsp.protocol.make_client_capabilities() itself.
vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })

vim.lsp.enable({
	"lua_ls",
	"nixd",
	"rust_analyzer",
})
