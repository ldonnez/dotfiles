return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>dvo", ":DiffviewOpen <CR>", silent = true, desc = "Diff view open" },
    { "<leader>dvf", ":DiffviewFileHistory % <CR>", silent = true, desc = "Current file history" },
    { "<leader>dvb", ":DiffviewFileHistory <CR>", silent = true, desc = "Current branch history" },
    { "<leader>dvc", ":DiffviewClose <CR>", silent = true, desc = "Close" },
  },
  config = true,
}
