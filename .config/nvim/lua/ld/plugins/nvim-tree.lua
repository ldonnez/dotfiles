vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_show_icons = {
  ["git"] = 1,
  ["folders"] = 1,
  ["files"] = 1,
  ["folder_arrows"] = 1,
}

require("nvim-tree").setup({
  diagnostics = {
    enable = true,
  },
  disable_netrw = false,
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
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

vim.keymap.set("n", "<C-e>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
