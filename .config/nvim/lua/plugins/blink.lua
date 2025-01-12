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
      cmdline = {
        preset = "super-tab",
      },
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
      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          auto_insert = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
        },
      },
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
