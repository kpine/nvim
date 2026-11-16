---@type vim.lsp.Config
return {
  on_init = function(client)
    -- Hover is basedpyright's job
    client.server_capabilities.hoverProvider = false
  end,
}
