local global = require("global")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.defer_fn(function()
  autocmd({ "TermOpen" }, { pattern = "*", command = "setlocal nonumber list" })

  autocmd({ "FileType" }, {
    pattern = "mail",
    command = "set noautoindent | setlocal nosmartindent | setlocal textwidth=72 | setlocal nonumber",
  })

  if global.is_wsl then
    autocmd("TextYankPost", {

      group = augroup("Yank", { clear = true }),

      callback = function()
        vim.fn.system("clip.exe", vim.fn.getreg('"'))
      end,
    })
  end
end, 10)
