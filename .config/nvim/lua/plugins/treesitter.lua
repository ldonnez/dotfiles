local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("nvim-treesitter.install").compilers = { "clang", "gcc" }
  require("nvim-treesitter.configs").setup({
    indent = {
      enable = true,
    },
    ensure_installed = {
      "javascript",
      "typescript",
      "html",
      "css",
      "tsx",
      "vim",
      "lua",
      "json",
      "jsonc",
      "yaml",
      "prisma",
      "graphql",
      "http",
      "markdown",
      "markdown_inline",
      "haskell",
      "sql",
      "terraform",
      "go",
      "bash",
    },
    highlight = { enable = true, disable = { "yaml" } },
  })
end

return M
