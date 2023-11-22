return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
    },
  },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format",
    },
  },
}
