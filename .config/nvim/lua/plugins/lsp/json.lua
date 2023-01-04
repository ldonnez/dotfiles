local lspconfig = require("lspconfig")
local capabilities = require("plugins.lsp.utils").capabilities()
local on_attach = require("plugins.lsp.utils").on_attach

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end,
    },
  },
})
