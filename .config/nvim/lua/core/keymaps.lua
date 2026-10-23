local g = vim.g
local keymap = vim.keymap

g.mapleader = ","

keymap.set("i", "jj", "<esc>", { silent = true, desc = "Remap esc" })
keymap.set("n", "j", "gj", { silent = true, desc = "Remap esc" })
keymap.set("n", "k", "gk", { silent = true, desc = "Remap esc" })

keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Go to previous buffer" })
keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Go to next buffer" })

keymap.set("n", "<leader>y", function()
  ---@diagnostic disable-next-line: undefined-field
  local path = vim.fn.expand("%")
  ---@diagnostic disable-next-line: undefined-field
  local relative_path = vim.fn.fnamemodify(path, ":~:.")

  ---@diagnostic disable-next-line: undefined-field
  vim.fn.setreg("+", relative_path)

  print("Copied to clipboard: " .. relative_path)
end, { silent = true, desc = "Copy current file path to clipboard" })

keymap.set("n", "<leader><space>", function()
  ---@diagnostic disable-next-line: undefined-field
  local view = vim.fn.winsaveview() -- Wrap to save cursor position

  vim.cmd([[%s/\s\+$//e]]) -- remove trailing whitespace
  vim.cmd([[%s/\r//ge]]) -- remove ^M characters

  ---@diagnostic disable-next-line: undefined-field
  vim.fn.winrestview(view)
end, { silent = true, desc = "Remove whitespace and ^M" })

keymap.set(
  "v",
  "*",
  [[y/\V<C-R>=escape(@",'/\')<CR><CR>]],
  { silent = true, desc = "Find other occurances of visualy selected" }
)
