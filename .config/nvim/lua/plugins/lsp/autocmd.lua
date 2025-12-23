local autocmd = vim.api.nvim_create_autocmd
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local keymap = vim.keymap

autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    if not client then
      return
    end

    local function nmap(lhs, rhs, desc)
      keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    nmap("<C-k>", lsp.buf.signature_help, "Show signature")
    nmap("gd", lsp.buf.definition, "Go to definition")
    nmap("gD", lsp.buf.declaration, "Go to declaration")
    nmap("gi", lsp.buf.implementation, "Go to implementation")

    nmap("gr", lsp.buf.references, "vim.lsp.buf.references")
    nmap("<leader>D", lsp.buf.definition, "vim.lsp.buf.definition")

    ---- Actions
    nmap("<leader>rn", lsp.buf.rename, "vim.lsp.buf.code_action")
    nmap("<leader>ca", lsp.buf.code_action, "vim.lsp.buf.code_action")

    ---- Diagnostics
    nmap("<leader>e", diagnostic.open_float, "vim.diagnostic.open_float")

    ----Custom server capabilities
    if client and client.server_capabilities and client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = true
    end
  end,
})
