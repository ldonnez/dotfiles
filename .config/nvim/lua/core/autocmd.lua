local global = require("global")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local fn = vim.fn

vim.defer_fn(function()
  autocmd({ "TermOpen" }, { pattern = "*", command = "setlocal nonumber list" })

  if global.is_wsl then
    autocmd("TextYankPost", {

      group = augroup("Yank", { clear = true }),

      callback = function()
        fn.system("clip.exe", fn.getreg('"'))
      end,
    })
  end
end, 10)

autocmd({ "FileType" }, {
  pattern = "mail",
  command = "set noautoindent | setlocal nosmartindent | setlocal textwidth=72 | setlocal nonumber",
})

autocmd({ "FileType" }, {
  pattern = "markdown",
  command = "setlocal spell spelllang=en,nl",
})
