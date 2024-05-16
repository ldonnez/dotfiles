local M = {}

local keymap = vim.keymap
local diagnostic = vim.diagnostic

keymap.set("n", "<leader>e", diagnostic.open_float, { silent = true, desc = "Open diagnostic" })
keymap.set("n", "<leader>q", diagnostic.setloclist, { silent = true, desc = "Set diagnostics in location list" })

function M.on_attach(_, bufnr)
  local lsp = vim.lsp

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  keymap.set("n", "gD", lsp.buf.declaration, { silent = true, buffer = bufnr, desc = "Go to declaration" })
  keymap.set("n", "gd", lsp.buf.definition, { silent = true, buffer = bufnr, desc = "Go to definition" })
  keymap.set("n", "gi", lsp.buf.implementation, { silent = true, buffer = bufnr, desc = "Go to implementation" })
  keymap.set("n", "<C-k>", lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "Show signature" })
  keymap.set(
    "n",
    "<leader>wa",
    lsp.buf.add_workspace_folder,
    { silent = true, buffer = bufnr, desc = "Add folder to workspace" }
  )
  keymap.set(
    "n",
    "<leader>wr",
    lsp.buf.remove_workspace_folder,
    { silent = true, buffer = bufnr, desc = "Remove from workspace" }
  )
  keymap.set("n", "<leader>wl", function()
    print(vim.inspect(lsp.buf.list_workspace_folders()))
  end, { silent = true, buffer = bufnr, desc = "List all workspace folders" })
  keymap.set(
    "n",
    "<leader>D",
    lsp.buf.type_definition,
    { silent = true, buffer = bufnr, desc = "Go to type definition" }
  )
  keymap.set("n", "<leader>rn", lsp.buf.rename, { silent = true, buffer = bufnr, desc = "Rename" })
  keymap.set("n", "<leader>ca", lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "Code action" })
  keymap.set(
    "n",
    "gr",
    lsp.buf.references,
    { silent = true, buffer = bufnr, desc = "Show references in quick fix list" }
  )
  --keymap.set("n", "<leader>f", function()
  --  lsp.buf.format({ async = true })
  --end, { silent = true, buffer = bufnr, desc = "Format" })
end

return M
