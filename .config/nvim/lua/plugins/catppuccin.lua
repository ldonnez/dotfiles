return {
  "catppuccin/nvim",
  name = "catppuccin",
  version = "*",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      -- Override blink background text to make it the same as vim background.
      custom_highlights = function(colors)
        return {
          BlinkCmpMenu = { fg = colors.text },
        }
      end,
      auto_integrations = true,
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
