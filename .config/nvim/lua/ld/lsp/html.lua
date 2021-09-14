local utils = require("ld.lsp.utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
  cmd = utils.get_cmd_executable("vscode-html-language-server"),
  capabilities = capabilities,
})
