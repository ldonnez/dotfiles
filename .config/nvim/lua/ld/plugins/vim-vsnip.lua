vim.api.nvim_set_keymap(
  "i",
  "<C-l>",
  [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']],
  { expr = true }
)

vim.api.nvim_set_keymap(
  "s",
  "<C-l>",
  [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']],
  { expr = true }
)

vim.api.nvim_set_keymap("i", "<C-j>", [[vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>']], { expr = true })
vim.api.nvim_set_keymap("s", "<C-j>", [[vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>']], { expr = true })

vim.api.nvim_set_keymap(
  "i",
  "<Tab>",
  [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
  { expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "s",
  "<Tab>",
  [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
  { expr = true, noremap = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<S-Tab>",
  [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
  { expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "s",
  "<S-Tab>",
  [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
  { expr = true, noremap = true }
)
