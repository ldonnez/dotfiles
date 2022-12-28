local global = require("config.global")

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    config = function()
      require("plugins.lsp.json")
      require("plugins.lsp.eslint")
      require("plugins.lsp.html")
      require("plugins.lsp.css")
      require("plugins.lsp.yaml")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "lua", "json", "yaml" },
    config = function()
      local utils = require("plugins.lsp.utils")
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        require("typescript.extensions.null-ls.code-actions"),
      }

      require("null-ls").setup({
        sources = sources,
        on_attach = utils.on_attach,
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
    config = function()
      require("plugins.lsp.lua")
    end,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require("plugins.lsp.typescript")
    end,
  },
}
