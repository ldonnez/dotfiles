return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  dependencies = {
    {
      "kristijanhusak/vim-dadbod-completion",
      "rafamadriz/friendly-snippets",
    },
  },
  opts = {
    keymap = {
      preset = "enter",
    },
    cmdline = {
      keymap = {
        preset = "super-tab",
      },
      completion = { menu = { auto_show = true } },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "dadbod" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    completion = {
      menu = { border = "rounded" },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = { border = "rounded" },
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = { enabled = true, window = { border = "rounded" } },
  },
}
