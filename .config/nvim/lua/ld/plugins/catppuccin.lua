require("catppuccin").setup({
  flavour = "frappe",
  integrations = {
    treesitter = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    dashboard = false,
    nvimtree = true,
    which_key = true,
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
  },
})

vim.cmd.colorscheme("catppuccin")
