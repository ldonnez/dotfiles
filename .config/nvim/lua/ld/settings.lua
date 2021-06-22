local global = require 'ld.global'

vim.opt.inccommand = "nosplit"
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.path = '+=**'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ruler = true
vim.opt.list = true
vim.opt.winwidth = 79
vim.opt.listchars = { ["tab"] = ">.",["trail"] = "~", ["extends"] = ">", ["precedes"] = "<", ["nbsp"] = "␣" }
vim.opt.modifiable = true
vim.opt.laststatus = 2
vim.opt.diffopt = "hiddenoff"
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.updatetime = 300
vim.opt.signcolumn= "auto"
vim.optshortmess = "aT"
vim.opt.wildmenu = true
vim.opt.wildignore = {"*/tmp/*","*.so","*.swp","*.zip","*.jpg","*.png",".git/*","node_modules/*" }
vim.opt.clipboard = {'unnamed', 'unnamedplus'}
vim.opt.cursorline = true
vim.opt.foldmethod = "marker"
vim.opt.foldlevelstart = 10
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.swapfile = true
vim.opt.backupdir = global.backup_dir .. "//"
vim.opt.directory = global.swap_dir .. "//"
vim.opt.undodir = global.undo_dir .. "//"
vim.opt.backupskip = "/tmp/*"

vim.opt.guifont = "Hack:h16"

if vim.fn.getenv('TERM_PROGRAM') ~= 'Apple_Terminal' then
  vim.opt.termguicolors = true
end

if vim.fn.isdirectory(global.backup_dir) ~= 1 then
  vim.fn.mkdir(global.backup_dir, "p")
end

vim.cmd[[au TermOpen * setlocal nonumber list]]
vim.cmd[[
  autocmd FileType mail set noautoindent | setlocal nosmartindent | setlocal textwidth=72 | setlocal nonumber
]]
