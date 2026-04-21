return {
  "catppuccin/nvim",
  name = "catppuccin",
  version = "*",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin-frappe")
  end,
}
