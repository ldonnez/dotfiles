require("nvim-autopairs").setup()
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
-- if not cmp_autopairs_status_ok then
--   vim.notify("cmp_autopairs not found")
--   return
-- end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
