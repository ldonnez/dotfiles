local global = require("global")

local opt = vim.opt
local g = vim.g

g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

opt.number = true
opt.path = "+=**"
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.splitbelow = true
opt.splitright = true
opt.list = true
opt.winwidth = 79
opt.listchars = { ["tab"] = ">.", ["trail"] = "~", ["extends"] = ">", ["precedes"] = "<", ["nbsp"] = "␣" }
opt.diffopt = "hiddenoff"
opt.showmatch = true
opt.showmode = false
opt.updatetime = 300
opt.shortmess = "aT"
opt.wildignore = { "*/tmp/*", "*.so", "*.swp", "*.zip", "*.jpg", "*.png", ".git/*", "node_modules/*" }
opt.clipboard = { "unnamed", "unnamedplus" }
opt.cursorline = true
opt.conceallevel = 2
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 20
opt.undofile = true
opt.backup = true
opt.writebackup = true
opt.backupdir = global.backup_dir .. "//"
opt.directory = global.swap_dir .. "//"
opt.undodir = global.undo_dir .. "//"
opt.completeopt = { "menu", "menuone", "noselect", "preview" }
opt.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
opt.timeoutlen = 300
