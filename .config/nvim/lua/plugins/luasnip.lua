return {
  "L3MON4D3/LuaSnip",
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
