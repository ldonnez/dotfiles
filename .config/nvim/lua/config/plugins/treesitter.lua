return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  priority = 999,
  config = function()
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
        "lua",
        "json",
        "jsonc",
        "yaml",
        "org",
        "prisma",
      },
      highlight = { enable = true, disable = { "yaml" }, additional_vim_regex_highlighting = { "org" } },
    })
  end,
}
