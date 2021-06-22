local global = require 'ld.global'

vim.g.workspace_autosave = 0
vim.g.workspace_session_directory = global.config_dir .. 'sessions/'
vim.g.workspace_undodir = global.undo_dir
vim.g.workspace_create_new_tabs = 0
