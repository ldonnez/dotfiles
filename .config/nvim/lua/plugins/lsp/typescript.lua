local ok, typescript = pcall(require, "typescript")
if not ok then
  vim.notify("typescript.nvim not found")
  return
end

local capabilities = require("plugins.lsp.utils").capabilities()
local on_attach = require("plugins.lsp.utils").on_attach

typescript.setup({
  disable_commands = false,
  debug = false,
  go_to_source_definition = {
    fallback = true,
  },
  server = { -- pass options to lspconfig's setup method
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
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
