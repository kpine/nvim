---@type vim.lsp.Config
return {
  on_init = function(client)
    -- Formatting is StyLua's job (see .stylua.toml). Clearing these here, before the client attaches
    -- to buffers, also stops Neovim from routing `gq` through lua_ls via 'formatexpr'.
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  on_attach = function(client)
    -- Reduce very long list of triggers for better 'mini.completion' experience
    local provider = client.server_capabilities.completionProvider
    if provider then provider.triggerCharacters = { '.', ':', '#', '(' } end
  end,
}
