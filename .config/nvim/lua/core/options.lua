-- enable new ui
require("vim._core.ui2").enable()

local opt = vim.opt
local g = vim.g
local state_dir = vim.fn.stdpath("state")

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
opt.cursorline = true
opt.conceallevel = 2
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 20
opt.foldtext = ""
opt.foldcolumn = "auto:1"
opt.fillchars = {
  fold = " ",
  foldinner = " ",
  foldsep = " ",
}
opt.undofile = true
opt.backup = true
opt.writebackup = true
opt.backupdir = state_dir .. "/backup//"
opt.directory = state_dir .. "/swap//"
opt.undodir = state_dir .. "/undo//"
opt.completeopt = { "menu", "menuone", "noselect", "preview" }
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.timeoutlen = 300
opt.winborder = "rounded"
opt.clipboard = { "unnamed", "unnamedplus" }
