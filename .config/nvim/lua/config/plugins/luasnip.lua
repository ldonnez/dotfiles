return {
  "L3MON4D3/LuaSnip",
  tag = "v1.1.0",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
