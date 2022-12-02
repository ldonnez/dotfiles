vim.g.mapleader = ","

vim.keymap.set("i", "jj", "<esc>", { silent = true, desc = "Remap esc" })
vim.keymap.set("n", "j", "gj", { silent = true, desc = "Remap esc" })
vim.keymap.set("n", "k", "gk", { silent = true, desc = "Remap esc" })

vim.keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC<CR>", { silent = true, desc = "Vertical split nvim config" })
vim.keymap.set("n", "<leader><space>", [[:%s/\s\+$//<CR>]], { silent = true, desc = "Remove whitespace" })

vim.keymap.set(
  "v",
  "*",
  [[y/\V<C-R>=escape(@",'/\')<CR><CR>]],
  { silent = true, desc = "Find other occurances of visualy selected" }
)
