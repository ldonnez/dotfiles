local global = require("ld.global")

vim.opt.number = true
vim.opt.path = "+=**"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.list = true
vim.opt.winwidth = 79
vim.opt.listchars = { ["tab"] = ">.", ["trail"] = "~", ["extends"] = ">", ["precedes"] = "<", ["nbsp"] = "␣" }
vim.opt.modifiable = true
vim.opt.diffopt = "hiddenoff"
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.updatetime = 300
vim.opt.shortmess = "aT"
vim.opt.wildignore = { "*/tmp/*", "*.so", "*.swp", "*.zip", "*.jpg", "*.png", ".git/*", "node_modules/*" }
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.cursorline = true
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 10
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.backupdir = global.backup_dir .. "//"
vim.opt.directory = global.swap_dir .. "//"
vim.opt.undodir = global.undo_dir .. "//"
vim.opt.backupskip = "/tmp/*"
vim.opt.guifont = "Hack:h16"
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local color_term = vim.fn.getenv("COLORTERM")
if color_term == "truecolor" or color_term == "24bit" then
  vim.opt.termguicolors = true
end

if vim.fn.isdirectory(global.backup_dir) ~= 1 then
  vim.fn.mkdir(global.backup_dir, "p")
end

vim.api.nvim_create_autocmd({ "TermOpen" }, { pattern = "*", command = "setlocal nonumber list" })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "mail",
  command = "set noautoindent | setlocal nosmartindent | setlocal textwidth=72 | setlocal nonumber",
})
