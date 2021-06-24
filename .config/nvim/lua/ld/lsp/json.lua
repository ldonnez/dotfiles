local lspconfig = require"lspconfig"
local utils = require"ld.lsp.utils"

lspconfig.jsonls.setup {
    cmd = utils.get_cmd_executable("vscode-json-language-server"),
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}

