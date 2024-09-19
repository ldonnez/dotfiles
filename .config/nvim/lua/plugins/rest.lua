return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  version = "*",
  keys = {
    { "<leader>rr", "<cmd>Rest run<CR>", desc = "Run HTTP Request under cursor" },
    { "<leader>ro", "<cmd>Rest open<CR>", desc = "Open rest" },
    { "<leader>rl", "<cmd>Rest logs<CR>", desc = "Rest logs" },
    { "<leader>ra", "<cmd>Rest last<CR>", desc = "Re-run last request" },
    { "<leader>re", "<cmd>Rest env show<CR>", desc = "Show rest env" },
    { "<leader>rs", "<cmd>Rest env select<CR>", desc = "Select rest env" },
  },
  opts = {},
}
