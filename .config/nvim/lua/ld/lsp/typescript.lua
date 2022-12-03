local ok, _ = pcall(require, "typescript")
if not ok then
  return
end

local utils = require("ld.lsp.utils")

require("typescript").setup({
  disable_commands = false,
  debug = false,
  go_to_source_definition = {
    fallback = true,
  },
  server = { -- pass options to lspconfig's setup method
    on_attach = function(client, bufnr)
      utils.on_attach(client, bufnr)
      vim.keymap.set("n", "gR", ":TypescriptRenameFile <CR>", { buffer = bufnr, desc = "Rename file" })
      vim.keymap.set(
        "n",
        "gd",
        ":TypescriptGoToSourceDefinition <CR>",
        { buffer = bufnr, desc = "Go to source definition" }
      )
    end,
  },
})
