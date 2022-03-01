vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_show_icons = {
  ["git"] = 1,
  ["folders"] = 0,
  ["files"] = 0,
  ["folder_arrows"] = 0,
}

require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    icons = { hint = "H", info = "I", warning = "W", error = "E" },
  },
  disable_netrw = false,
  view = {
    auto_resize = true,
    mappings = {
      list = {
        { key = "<C-e>", action = "" },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

vim.api.nvim_set_keymap("n", "<C-e>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
