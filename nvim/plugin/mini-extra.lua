require("mini.extra").setup()

vim.keymap.set("n", "<leader>q", MiniExtra.pickers.diagnostic, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>sk", MiniExtra.pickers.keymaps, { desc = "Search keymaps" })
