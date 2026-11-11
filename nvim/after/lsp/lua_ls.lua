---@type vim.lsp.Config
return {
  on_attach = function(client)
    -- Reduce very long list of triggers for better 'mini.completion' experience
    local provider = client.server_capabilities.completionProvider
    if provider then provider.triggerCharacters = { '.', ':', '#', '(' } end
  end,
}
