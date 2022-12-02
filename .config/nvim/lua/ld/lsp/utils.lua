local global = require("ld.global")

local utils = {}

function utils.buf_set_keymap(bufnr, ...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

function utils.buf_set_option(bufnr, ...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

function utils.get_cmd_executable(lsp_executable)
  if global.is_windows then
    return { lsp_executable .. ".cmd", "--stdio" }
  else
    return { lsp_executable, "--stdio" }
  end
end

function utils.cmp_capababilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  return capabilities
end

function utils.on_attach(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = bufnr, desc = "Go to declaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = bufnr, desc = "Go to definition" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = bufnr, desc = "Show type information (hover)" })
  vim.keymap.set(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    { silent = true, buffer = bufnr, desc = "Go to implementation" }
  )
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "Show signature" })
  vim.keymap.set(
    "n",
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    { silent = true, buffer = bufnr, desc = "Add folder to workspace" }
  )
  vim.keymap.set(
    "n",
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { silent = true, buffer = bufnr, desc = "Remove from workspace" }
  )
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { silent = true, buffer = bufnr, desc = "List all workspace folders" })
  vim.keymap.set(
    "n",
    "<leader>D",
    vim.lsp.buf.type_definition,
    { silent = true, buffer = bufnr, desc = "Go to type definition" }
  )
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, buffer = bufnr, desc = "Rename" })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "Code action" })
  vim.keymap.set(
    "n",
    "gr",
    vim.lsp.buf.references,
    { silent = true, buffer = bufnr, desc = "Show references in quick fix list" }
  )
  vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { silent = true, buffer = bufnr, desc = "Open diagnostic" }
  )
  vim.keymap.set(
    "n",
    "[d",
    vim.diagnostic.goto_prev,
    { silent = true, buffer = bufnr, desc = "Go to previous diagnostic" }
  )
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, buffer = bufnr, desc = "Go to next diagnostic" })
  vim.keymap.set(
    "n",
    "<leader>q",
    vim.diagnostic.setloclist,
    { silent = true, buffer = bufnr, desc = "Set diagnostics in location list" }
  )
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, { silent = true, buffer = bufnr, desc = "Format" })
end

return utils
