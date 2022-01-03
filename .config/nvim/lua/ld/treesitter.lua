require("nvim-treesitter.install").compilers = { "clang", "gcc" }
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.org = {
  install_info = {
    url = "https://github.com/milisims/tree-sitter-org",
    revision = "main",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  filetype = "org",
}

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
