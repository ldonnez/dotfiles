local capabilities = require("plugins.lsp.utils").capabilities()
local on_attach = require("plugins.lsp.utils").on_attach

require("lspconfig").cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
