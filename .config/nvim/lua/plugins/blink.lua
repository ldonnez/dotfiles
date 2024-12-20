return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  dependencies = {
    {
      "kristijanhusak/vim-dadbod-completion",
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "*",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
        end,
      },
    },
  },
  opts = {
    keymap = { preset = "enter" },
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "luasnip" },
      per_filetype = {
        sql = { "dadbod" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
      cmdline = {},
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = { enabled = true },
  },
}
