local utils = require("config.lsp.utils")

require("lspconfig").yamlls.setup({
  cmd = utils.get_cmd_executable("yaml-language-server"),
})
