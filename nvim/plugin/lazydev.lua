require('lazydev').setup({
  library = {
    -- Types for `vim.uv` (libuv bindings), loaded only when a file mentions `vim.uv`.
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})
