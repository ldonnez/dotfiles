vim.g.mapleader = ","
vim.keymap.set("i", "jj", "<esc>", { noremap = true, silent = true })
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC <CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC <CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><space>", [[:%s/\s\+$//<CR>]], { noremap = true, silent = true })
vim.keymap.set("v", "*", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { noremap = true, silent = true })

vim.api.nvim_create_user_command("BufOnly", [[execute '%bdelete|edit #|normal `"']], { nargs = 0 })
