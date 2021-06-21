local global = {}
local home    = os.getenv("HOME")

function global:load_variables()
  self.home = home
end

global:load_variables()

return global
