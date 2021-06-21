vim.api.nvim_set_keymap('n', '<C-e>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_show_icons = {
  ["git"] = 1,
  ["folders"] = 0,
  ["files"] = 0,
  ["folder_arrows"] = 0
}

