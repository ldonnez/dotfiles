local global = {}
local home = vim.fn.getenv("HOME")
local config = vim.fn.stdpath("config")

function global:load_variables()
  self.home_dir = home
  self.config_dir = config
  self.backup_dir = config .. "/backup"
  self.undo_dir = config .. "/undo"
  self.swap_dir = config .. "/swap"
  self.cache_dir = config .. "/cache"
end

global:load_variables()

return global
