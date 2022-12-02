vim.keymap.set(
  "i",
  "<C-l>",
  [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']],
  { expr = true, desc = "Expand/jump snip when available" }
)

vim.keymap.set(
  "s",
  "<C-l>",
  [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']],
  { expr = true, desc = "Expand/jump snip when available" }
)

vim.keymap.set(
  "i",
  "<C-j>",
  [[vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>']],
  { expr = true, desc = "Expand snip when available" }
)

vim.keymap.set(
  "s",
  "<C-j>",
  [[vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>']],
  { expr = true, desc = "Expand snip when available" }
)

vim.keymap.set(
  "i",
  "<Tab>",
  [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
  { expr = true, noremap = true, desc = "Jump forward when available" }
)
vim.keymap.set(
  "s",
  "<Tab>",
  [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
  { expr = true, noremap = true, desc = "Jump forward when available" }
)

vim.keymap.set(
  "i",
  "<S-Tab>",
  [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
  { expr = true, noremap = true, desc = "Jump backward when available" }
)
vim.keymap.set(
  "s",
  "<S-Tab>",
  [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
  { expr = true, noremap = true, desc = "Jump backward when available" }
)
