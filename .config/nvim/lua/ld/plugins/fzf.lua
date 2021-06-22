vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', ':GFiles?<CR>', { noremap = true, silent = true })

vim.cmd[[let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores -l -g ""']]

vim.g.fzf_layout = { window = { width = 0.7, height = 0.6, yoffset = 0.1, xoffset = 0.5, border = "sharp" } }

if vim.fn.has('win32') == 0 then
  vim.g.fzf_preview_window = 'down:60%'
else
  vim.g.fzf_preview_window = {}
end

vim.g.fzf_action = { ["ctrl-t"] = "tab split"; ["ctrl-x"] = "split", ["ctrl-v"] = "vsplit" }

vim.g.fzf_colors = {
   ["fg"] =      {"fg", "Normal"},
   ["bg"]  =     {"bg", 'Normal'},
   ["hl"]  =     {"fg", 'Comment'},
   ["fg+"]  =    {"fg", 'CursorLine', 'CursorColumn', 'Normal'},
   ["bg+"]  =    {"bg", 'CursorLine', 'CursorColumn'},
   ["hl+"] =     {"fg", 'Statement'},
   ["info"] =    {"fg", 'PreProc'},
   ["border"]  = {"fg", 'Ignore'},
   ["prompt"]  = {"fg", 'Conditional'},
   ["pointer"] = {"fg", 'Exception'},
   ["marker"] =  {"fg", 'Keyword'},
   ["spinner"] = {"fg", 'Label'},
   ["header"]  = {"fg", 'Comment'}
}
