local lspconfig = require"lspconfig"

local function get_cmd()
  if vim.fn.has('win32') == 1 then
    return { "vscode-json-language-server.cmd", "--stdio" }
  else
    return { "vscode-json-language-server", "--stdio" }
  end
end

lspconfig.jsonls.setup {
    cmd = get_cmd(),
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}

