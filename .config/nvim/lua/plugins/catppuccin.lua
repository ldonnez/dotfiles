return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "frappe",
    -- Override blink colors until color issues fixed in catppuccin.
    custom_highlights = function(colors)
      return {
        BlinkCmpMenu = { fg = colors.text },
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
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
