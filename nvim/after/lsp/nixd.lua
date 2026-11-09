-- Merged over nvim-lspconfig's lsp/nixd.lua (after/ wins on conflicts).
---@type vim.lsp.Config
return {
	settings = {
		nixd = {
			-- `<nixpkgs>` resolves via NIX_PATH; on NixOS this is your system flake's nixpkgs.
			nixpkgs = { expr = "import <nixpkgs> { }" },
			formatting = { command = { "nixfmt" } },
			options = {
				-- Generic NixOS options. For options from your own modules, point this at
				-- `(builtins.getFlake "/path/to/config").nixosConfigurations.<host>.options`.
				nixos = { expr = "(import <nixpkgs/nixos> { configuration = { }; }).options" },
			},
		},
	},
}
