local global = require("global")
local keymaps = require("plugins.lsp.keymaps")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    config = function()
      local servers = require("plugins.lsp.setup")

      for server, opts in pairs(servers) do
        opts.capabilities = capabilities
        opts.on_attach = keymaps.on_attach
        require("lspconfig")[server].setup(opts)
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "lua", "json", "yaml" },
    config = function()
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        require("typescript.extensions.null-ls.code-actions"),
      }

      null_ls.setup({
        sources = sources,
      })
    end,
  },
  {
    "luals/lua-language-server",
    cond = false,
    version = "*",
    build = global.is_unix and [[./make.sh]] or [[.\make.bat]],
  },
  {
    "folke/neodev.nvim",
    ft = { "lua", "luau" },
    config = true,
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json" },
    opts = {
      on_attach = function(client, bufnr)
        keymaps.on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        local keymap = vim.keymap
        keymap.set(
          "n",
          "gd",
          ":TSToolsGoToSourceDefinition <CR>",
          { silent = true, buffer = bufnr, desc = "Go to source definition" }
        )
      end,
    },
  },
}
