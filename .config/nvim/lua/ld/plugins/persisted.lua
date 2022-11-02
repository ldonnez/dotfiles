require("persisted").setup({
  autoload = true,
  branch_separator = "_",
  allowed_dirs = {
    "~/projects",
    "~/config",
    "~/dotfiles",
  },
})
