local config = vim.fn.stdpath("config")
local data = vim.fn.stdpath("data")

return {
  backup_dir = config .. "/backup",
  undo_dir = config .. "/undo",
  swap_dir = config .. "/swap",
  plugin_installation_path = data .. "/lazy",
  is_windows = vim.fn.has("win32") == 1,
  is_unix = vim.fn.has("unix") == 1,
  is_wsl = vim.fn.has("wsl") == 1,
}
