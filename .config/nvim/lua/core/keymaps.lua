local g = vim.g
local keymap = vim.keymap

g.mapleader = ","

keymap.set("i", "jj", "<esc>", { silent = true, desc = "Remap esc" })
keymap.set("n", "j", "gj", { silent = true, desc = "Remap esc" })
keymap.set("n", "k", "gk", { silent = true, desc = "Remap esc" })
keymap.set("n", "<leader>y", function()
  local path = vim.fn.expand("%")
  local relative_path = vim.fn.fnamemodify(path, ":~:.")

  vim.fn.setreg("+", relative_path)

  print("Copied to clipboard: " .. relative_path)
end, { silent = true, desc = "Copy current file path to clipboard" })

keymap.set("n", "<leader><space>", [[:%s/\s\+$//<CR>]], { silent = true, desc = "Remove whitespace" })

keymap.set(
  "v",
  "*",
  [[y/\V<C-R>=escape(@",'/\')<CR><CR>]],
  { silent = true, desc = "Find other occurances of visualy selected" }
)
