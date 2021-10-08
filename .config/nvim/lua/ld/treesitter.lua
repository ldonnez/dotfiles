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
    "org",
  },
  highlight = { enable = true, disable = { "yaml" }, additional_vim_regex_highlighting = { "org" } },
})

vim.cmd([[
    hi link OrgAgendaDay Directory
    hi! link TSWarning WarningMsg
    hi! link TSDanger ErrorMsg
    hi clear TsNote
  ]])
