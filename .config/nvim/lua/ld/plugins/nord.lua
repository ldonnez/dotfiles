-- Custom higlight Diagnostics until nvim 0.6 improvements are merged in the nord-vim repo
vim.cmd([[ autocmd ColorScheme nord highlight DiagnosticWarn ctermfg=3 guifg=#EBCB8B ]])
vim.cmd([[ autocmd ColorScheme nord highlight DiagnosticError ctermfg=1 guifg=#BF616A ]])
vim.cmd([[ autocmd ColorScheme nord highlight DiagnosticInfo ctermfg=6 guifg=#88C0D0 ]])
vim.cmd([[ autocmd ColorScheme nord highlight DiagnosticHint ctermfg=12 guifg=#5E81AC ]])
vim.cmd(
  [[ autocmd ColorScheme nord highlight DiagnosticUnderlineWarn ctermfg=3 guifg=#EBCB8B gui=undercurl cterm=underline ]]
)
vim.cmd(
  [[ autocmd ColorScheme nord highlight DiagnosticUnderlineError ctermfg=1 guifg=#BF616A gui=undercurl cterm=underline ]]
)
vim.cmd(
  [[ autocmd ColorScheme nord highlight DiagnosticUnderlineInfo ctermfg=6 guifg=#88C0D0 gui=undercurl cterm=underline ]]
)
vim.cmd(
  [[ autocmd ColorScheme nord highlight DiagnosticUnderlineHint ctermfg=12 guifg=#5E81AC gui=undercurl cterm=underline ]]
)

vim.cmd([[
	silent! colorscheme nord
]])

vim.g.nord_italic = 1
vim.g.nord_bold = 1
vim.g.nord_underline = 1
vim.g.nord_italic_comments = 1
vim.g.nord_cursor_line_number_background = 1
vim.g.nord_uniform_status_lines = 1
