local completion = require('mini.completion')

-- After fuzzy filtering, order items by kind: snippets (from mini.snippets and from
-- language servers) go below everything else, so fields, methods and variables come first.
-- Kinds not listed default to priority 100; a negative priority hides that kind entirely.
local kind_priority = { Text = -1, Snippet = 99 }

completion.setup({
  lsp_completion = {
    process_items = function(items, base)
      return completion.default_process_items(items, base, { kind_priority = kind_priority })
    end,
  },
})
