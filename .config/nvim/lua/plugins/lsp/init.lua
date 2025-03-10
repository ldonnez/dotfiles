local global = require("global")
local keymaps = require("plugins.lsp.keymaps")
local lsp = vim.lsp

-- Adds a border to the document hover window (vim.lsp.buf.hover())
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
  border = "rounded",
})

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      local servers = require("plugins.lsp.setup")

      for server, opts in pairs(servers) do
        local capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)
        opts.capabilities = capabilities
        opts.on_attach = keymaps.on_attach
        require("lspconfig")[server].setup(opts)
      end
    end,
  },
  {
    "luals/lua-language-server",
    version = "*",
    build = global.is_unix and [[./make.sh]] or [[.\make.bat]],
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
        keymaps.on_attach(client, bufnr)
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
