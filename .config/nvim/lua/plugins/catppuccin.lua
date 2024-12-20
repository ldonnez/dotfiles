return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
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
      integrations = {
        treesitter = true,
        fzf = true,
        cmp = false,
        blink_cmp = true,
        gitsigns = true,
        telescope = false,
        dashboard = false,
        neotree = true,
        which_key = true,
        nvim_surround = true,
        diffview = true,
        indent_blankline = {
          enabled = false,
          colored_indent_levels = false,
        },
        mini = {
          enabled = false,
        },
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
