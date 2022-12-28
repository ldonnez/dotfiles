return {
  "kyazdani42/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  keys = { "<C-e>", "<leader>n" },
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

    vim.keymap.set("n", "<C-e>", ":NvimTreeToggle <CR>", { desc = "Open tree" })
    vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { desc = "Go to current file in tree" })
  end,
}
