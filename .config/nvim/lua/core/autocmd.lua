local autocmd = vim.api.nvim_create_autocmd

vim.defer_fn(function()
  autocmd({ "TermOpen" }, { pattern = "*", command = "setlocal listchars= nonumber" })
end, 10)

-- Show all .env.* files with syntax highlights.
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".env.*",
  command = "set filetype=sh",
})
