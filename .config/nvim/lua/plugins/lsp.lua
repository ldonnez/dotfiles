local pack = require("pack")

local servers = {
  cssls = {},
  eslint = {},
  html = {},
  jsonls = {},
  ansiblels = {},
  graphql = {},
  hls = { filetypes = { "haskell", "lhaskell", "cabal" } },
  yamlls = {
    settings = {
      yaml = { schemas = { ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*" } },
    },
  },
  emmylua_ls = {},
  tailwindcss = {},
  prismals = {},
  terraformls = {},
  vtsls = {
    settings = {
      vtsls = {
        autoUseWorkspaceTsdk = true,
        experimental = { completion = { enableServerSideFuzzyMatch = true, entriesLimit = 1000 } },
        typescript = { updateImportsOnFileMove = "always", tsserver = { maxTsServerMemory = 8192 } },
      },
    },
  },
  bashls = {},
  gopls = {},
  kulala_ls = {},
  golangci_lint_ls = {},
}

pack.load({ "https://github.com/neovim/nvim-lspconfig" }, { events = { "BufReadPost" } }, function()
  for server, opts in pairs(servers) do
    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end
end)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    if not client then
      return
    end

    local function nmap(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    nmap("<C-k>", vim.lsp.buf.signature_help, "Show signature")
    nmap("gd", vim.lsp.buf.definition, "Go to definition")
    nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
    nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
    nmap("gr", vim.lsp.buf.references, "vim.lsp.buf.references")
    nmap("<leader>D", vim.lsp.buf.definition, "vim.lsp.buf.definition")
    nmap("<leader>rn", vim.lsp.buf.rename, "vim.lsp.buf.code_action")
    nmap("<leader>ca", vim.lsp.buf.code_action, "vim.lsp.buf.code_action")
    nmap("<leader>e", vim.diagnostic.open_float, "vim.diagnostic.open_float")

    if client.server_capabilities and client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = true
    end

    if client.server_capabilities and client.name == "terraformls" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
