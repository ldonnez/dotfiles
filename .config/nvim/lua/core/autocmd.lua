local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

vim.defer_fn(function()
  autocmd({ "TermOpen" }, { pattern = "*", command = "setlocal listchars= nonumber" })
end, 10)

autocmd({ "FileType" }, {
  pattern = "mail",
  command = "set noautoindent | setlocal nosmartindent | setlocal textwidth=72 | setlocal nonumber",
})

autocmd({ "FileType" }, {
  pattern = { "markdown", "gitcommit", "mail" },
  command = "setlocal spell spelllang=en,nl spelloptions=camel",
})

autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    opt.foldlevel = 1
    opt.foldlevelstart = 1
  end,
})

autocmd({ "FileType" }, {
  pattern = { "json" },
  callback = function()
    vim.bo.formatprg = "jq"
  end,
})

-- Show all .env.* files with syntax highlights.
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".env.*",
  command = "set filetype=sh",
})
