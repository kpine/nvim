local files = require('mini.files')
files.setup()

vim.keymap.set('n', '-', files.open, { desc = 'Toggle mini file explorer' })

-- Open file window in the directory of the current file
vim.keymap.set('n', '<leader>-', function()
  files.open(vim.api.nvim_buf_get_name(0), false)
  files.reveal_cwd()
end, { desc = 'Toggle mini file explorer into directory of currently opened file' })
