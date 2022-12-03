local utils = require("ld.lsp.utils")
local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.prettierd,
  require("typescript.extensions.null-ls.code-actions"),
}

require("null-ls").setup({
  sources = sources,
  on_attach = utils.on_attach,
})
