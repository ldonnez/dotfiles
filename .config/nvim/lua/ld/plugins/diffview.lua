require("diffview").setup({})

vim.keymap.set("n", "<leader>dvo", ":DiffviewOpen <CR>", { desc = "Diff view open" })
vim.keymap.set("n", "<leader>dvf", ":DiffviewFileHistory % <CR>", { desc = "Current file history" })
vim.keymap.set("n", "<leader>dvb", ":DiffviewFileHistory <CR>", { desc = "Current branch history" })
vim.keymap.set("n", "<leader>dvc", ":DiffviewClose <CR>", { desc = "Close" })
