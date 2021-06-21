local global = {}
local home = vim.fn.getenv("HOME")

function global:load_variables()
  self.home = home
end

global:load_variables()

return global
