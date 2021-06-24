vim.g.mapleader = ","
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsplit $MYVIMRC <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><space>', [[:%s/\s\+$//<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '*', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { noremap = true, silent = true })

vim.cmd[[command! BufOnly execute '%bdelete|edit #|normal `"']]
vim.cmd[[autocmd FileType json command! Format :exe "%!jq ."]]
