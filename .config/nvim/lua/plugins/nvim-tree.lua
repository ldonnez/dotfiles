return {
  "kyazdani42/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  keys = {
    { "<C-e>", ":NvimTreeToggle <CR>", desc = "Open tree" },
    { "<leader>n", ":NvimTreeFindFile<CR>", desc = "Go to current file in tree" },
  },
  config = function()
    require("nvim-tree").setup({
      diagnostics = {
        enable = true,
      },
      hijack_netrw = true,
      view = {
        mappings = {
          list = {
            { key = "<C-e>", action = "" },
          },
        },
      },
      filters = {
        dotfiles = false,
      },
      renderer = {
        highlight_git = true,
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        timeout = 500,
      },
    })
  end,
}
