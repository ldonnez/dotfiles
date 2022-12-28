local utils = require("plugins.lsp.utils")

require("lspconfig").yamlls.setup({
  cmd = utils.get_cmd_executable("yaml-language-server"),
})
