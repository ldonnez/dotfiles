local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function get_cmd()
  if vim.fn.has('win32') == 1 then
    return { "vscode-html-language-server.cmd", "--stdio" }
  else
    return { "vscode-html-language-server", "--stdio" }
  end
end

require'lspconfig'.html.setup {
  cmd = get_cmd(),
  capabilities = capabilities,
}
