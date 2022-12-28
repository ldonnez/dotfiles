return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>dvo", ":DiffviewOpen <CR>", desc = "Diff view open" },
    { "<leader>dvf", ":DiffviewFileHistory % <CR>", desc = "Current file history" },
    { "<leader>dvb", ":DiffviewFileHistory <CR>", desc = "Current branch history" },
    { "<leader>dvc", ":DiffviewClose <CR>", desc = "Close" },
  },
  config = true,
}
