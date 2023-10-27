return {
  "rest-nvim/rest.nvim",
  commit = "8b62563cfb19ffe939a260504944c5975796a682",
  ft = { "http", "json" },
  keys = {
    { "<leader>rr", "<Plug>RestNvim <CR>", desc = "Run HTTP Request under cursor" },
    { "<leader>rp", "<Plug>RestNvimPreview <CR>", desc = "Preview the request cURL command" },
    { "<leader>rl", "<Plug>RestNvimLast <CR>", desc = "Re-run last request" },
  },
  opts = {
    result_split_in_place = true,
  },
}
