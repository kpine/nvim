local extra = require("mini.extra")
extra.setup()

vim.keymap.set("n", "<leader>q", extra.pickers.diagnostic, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>sk", extra.pickers.keymaps, { desc = "Search keymaps" })
