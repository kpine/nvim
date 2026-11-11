-- LSP navigation through mini.extra pickers
local function lsp_pick(scope)
  return function() require('mini.extra').pickers.lsp({ scope = scope }) end
end

vim.keymap.set('n', 'gd', lsp_pick('definition'), { desc = 'Go to definition' })
vim.keymap.set('n', 'grr', lsp_pick('references'), { desc = 'Go to references' })
vim.keymap.set('n', 'gri', lsp_pick('implementation'), { desc = 'Go to implementation' })
vim.keymap.set('n', 'grt', lsp_pick('type_definition'), { desc = 'Go to type definition' })
vim.keymap.set('n', 'gO', lsp_pick('document_symbol'), { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>sS', lsp_pick('workspace_symbol_live'), { desc = 'Search workspace symbols' })

vim.diagnostic.config({
  severity_sort = true,
  float = { source = 'if_many' },
  virtual_text = { source = 'if_many' },
})

vim.lsp.config('*', { capabilities = require('mini.completion').get_lsp_capabilities() })

vim.lsp.enable({
  'lua_ls',
  'nixd',
  'rust_analyzer',
})
