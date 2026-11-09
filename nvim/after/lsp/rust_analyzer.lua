---@type vim.lsp.Config
return {
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" },
			procMacro = { enable = true },
			cargo = {
				buildScripts = { enable = true },
			},
		},
	},
}
