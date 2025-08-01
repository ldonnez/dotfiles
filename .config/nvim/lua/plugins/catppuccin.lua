return {
  "catppuccin/nvim",
  name = "catppuccin",
  version = "*",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "frappe",
    -- Override blink colors until color issues fixed in catppuccin.
    custom_highlights = function(colors)
      return {
        BlinkCmpKind = { fg = colors.blue },
        BlinkCmpMenu = { fg = colors.text },
        BlinkCmpMenuBorder = { fg = colors.blue },
        BlinkCmpDocBorder = { fg = colors.blue },
        BlinkCmpSignatureHelpActiveParameter = { fg = colors.mauve },
        BlinkCmpSignatureHelpBorder = { fg = colors.blue },
      }
    end,
    auto_integrations = true,
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
