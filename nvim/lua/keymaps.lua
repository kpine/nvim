-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Delete text without saving it to any register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

-- Ctrl-C to exit insert mode
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Move selected lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move visual selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move visual selection up' })

-- Preserve selection while indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and keep selection' })

-- Join lines without changing cursor position
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines without moving cursor' })

-- Keep cursor in the center of the buffer while paging up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down buffer with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up buffer with cursor centered' })

-- Keep cursor in the center of the buffer while incrementally searching
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result with cursor centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result with cursor centered' })

-- Globally replace the word under the cursor
vim.keymap.set(
  'n',
  '<leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word under cursor' }
)

-- Use native undotree
vim.keymap.set('n', '<leader>u', function()
  vim.cmd.packadd('nvim.undotree')
  require('undotree').open()
end, { desc = 'Toggle Undotree' })

-- Diff the windows in the current tab (works on unsaved buffers too), and turn it off again
vim.keymap.set('n', '<leader>wd', '<cmd>windo diffthis<CR>', { desc = 'Diff windows in tab' })
vim.keymap.set('n', '<leader>wo', '<cmd>diffoff!<CR>', { desc = 'Turn off diff in all windows' })
