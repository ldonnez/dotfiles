local lspconfig = require("lspconfig")
local utils = require("ld.lsp.utils")

lspconfig.tsserver.setup({
  capabilities = utils.cmp_capababilities(),
  on_attach = function(client, bufnr)
    utils.on_attach(client, bufnr)
  end,
})
