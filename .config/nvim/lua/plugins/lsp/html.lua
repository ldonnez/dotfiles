local on_attach = require("plugins.lsp.utils").on_attach
local capabilities = require("plugins.lsp.utils").capabilities()

require("lspconfig").html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
