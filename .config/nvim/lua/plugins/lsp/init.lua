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
    "sumneko/lua-language-server",
    cond = false,
    version = "*",
    build = global.is_unix and [[cd 3rd/luamake && compile/install.sh && cd ../.. && ./3rd/luamake/luamake rebuild]]
      or [[cd 3rd\luamake & compile\install.bat & cd ..\.. & 3rd\luamake\luamake.exe rebuild]],
  },
  {
    "folke/neodev.nvim",
    ft = { "lua", "luau" },
    config = true,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = {
      disable_commands = false,
      debug = false,
      go_to_source_definition = {
        fallback = true,
      },
      server = {
        capabilities = capabilities,
        on_attach = keymaps.on_attach,
      },
    },
  },
}
