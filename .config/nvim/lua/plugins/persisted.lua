return {
  "olimorris/persisted.nvim",
  event = "VeryLazy",
  config = function()
    require("persisted").setup({
      autoload = true,
      branch_separator = "_",
      allowed_dirs = {
        "~/projects",
        "~/config",
        "~/dotfiles",
      },
    })
  end,
}
