local home = vim.fn.getenv("HOME")
local config = vim.fn.stdpath("config")
local data = vim.fn.stdpath("data")

return {
  home_dir = home,
  config_dir = config,
  backup_dir = config .. "/backup",
  undo_dir = config .. "/undo",
  swap_dir = config .. "/swap",
  data = data,
  plugin_installation_path = data .. "/lazy",
  is_windows = vim.fn.has("win32") == 1,
  is_unix = vim.fn.has("unix") == 1,
  is_mac = vim.fn.has("mac") == 1,
}
