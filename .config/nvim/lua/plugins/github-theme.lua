return {
  "projekt0n/github-nvim-theme",
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("github-theme").setup()

    vim.cmd.colorscheme("github_dark")
  end,
}
