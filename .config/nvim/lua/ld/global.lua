local global = {}
local home = vim.fn.getenv("HOME")
local config = vim.fn.stdpath("config")
local data = vim.fn.stdpath("data")

function global:load_variables()
	self.home_dir = home
	self.config_dir = config
	self.backup_dir = config .. "/backup"
	self.undo_dir = config .. "/undo"
	self.swap_dir = config .. "/swap"
	self.cache_dir = config .. "/cache"
	self.data = data
	self.plugin_installation_path = data .. "/site/pack/packer/start"
	self.is_windows = vim.fn.has("win32") == 1
	self.is_unix = vim.fn.has("unix") == 1
	self.is_mac = vim.fn.has("mac") == 1
end

global:load_variables()

return global
