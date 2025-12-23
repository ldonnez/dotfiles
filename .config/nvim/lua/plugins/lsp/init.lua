return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      require("plugins.lsp.autocmd")
      local servers = require("plugins.lsp.setup")

      for server, opts in pairs(servers) do
        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "folke/lazydev.nvim",
    version = "*",
    ft = "lua",
  },
  {
    "mfussenegger/nvim-ansible",
    ft = { "yaml" },
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json" },
    enabled = false,
    opts = {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        local keymap = vim.keymap
        keymap.set(
          "n",
          "gD",
          ":TSToolsGoToSourceDefinition <CR>",
          { silent = true, buffer = bufnr, desc = "Go to source definition" }
        )
        keymap.set("n", "grn", ":TSToolsRenameFile <CR>", { silent = true, buffer = bufnr, desc = "Rename file" })
      end,
    },
  },
}
