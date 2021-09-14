require("nvim-treesitter.configs").setup({
  autopairs = { enable = true },
  autotag = {
    enable = true,
  },
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
  },
  highlight = { enable = true, disable = { "yaml" } },
})
