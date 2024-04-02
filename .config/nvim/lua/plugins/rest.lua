return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  version = "v1.2.1",
  keys = {
    { "<leader>rr", "<Plug>RestNvim <CR>", desc = "Run HTTP Request under cursor" },
    { "<leader>rp", "<Plug>RestNvimPreview <CR>", desc = "Preview the request cURL command" },
    { "<leader>rl", "<Plug>RestNvimLast <CR>", desc = "Re-run last request" },
  },
  opts = {
    result_split_in_place = true,
  },
}
