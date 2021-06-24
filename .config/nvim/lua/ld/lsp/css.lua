local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function get_cmd()
  if vim.fn.has('win32') == 1 then
    return { "vscode-css-language-server.cmd", "--stdio" }
  else
    return { "vscode-css-language-server", "--stdio" }
  end
end

require'lspconfig'.cssls.setup {
  cmd = get_cmd(),
  capabilities = capabilities,
}
