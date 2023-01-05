vim.defer_fn(function()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ "TermOpen" }, { pattern = "*", command = "setlocal nonumber list" })

  autocmd({ "FileType" }, {
    pattern = "mail",
    command = "set noautoindent | setlocal nosmartindent | setlocal textwidth=72 | setlocal nonumber",
  })
end, 10)
