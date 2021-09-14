local global = require("ld.global")

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require("packer").use
require("packer").startup(function()
  use("wbthomason/packer.nvim")
  use("tpope/vim-fugitive")
  use("thaerkh/vim-workspace")
  use("mattn/emmet-vim")
  use("jiangmiao/auto-pairs")
  use("alvan/vim-closetag")
  use("tpope/vim-surround")
  use("itchyny/lightline.vim")
  use("vimwiki/vimwiki")
  use("arcticicestudio/nord-vim")
  use("sheerun/vim-polyglot")
  use("airblade/vim-gitgutter")
  use("lervag/vimtex")
  use({
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end,
  })
  use("junegunn/fzf.vim")
  use("APZelos/blamer.nvim")
  use("tpope/vim-dadbod")
  use("kristijanhusak/vim-dadbod-ui")
  use("pantharshit00/vim-prisma")
  use("dhruvasagar/vim-table-mode")
  use("jose-elias-alvarez/null-ls.nvim")
  use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = { "nvim-lua/plenary.nvim" } })
  use("kyazdani42/nvim-tree.lua")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("neovim/nvim-lspconfig")
  use({ "hrsh7th/vim-vsnip", requires = {
    "rafamadriz/friendly-snippets",
  } })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
    },
  })
  use({
    "sumneko/lua-language-server",
    run = global.is_unix and [[cd 3rd/luamake && compile/install.sh && cd ../.. && ./3rd/luamake/luamake rebuild]]
      or [[cd 3rd\luamake & compile\install.bat & cd ..\.. & 3rd\luamake\luamake.exe rebuild]],
  })
end)

require("ld.plugins.emmet")
require("ld.plugins.fzf")
require("ld.plugins.git-blamer")
require("ld.plugins.git-gutter")
require("ld.plugins.vimtex")
require("ld.plugins.lightline")
require("ld.plugins.nord")
require("ld.plugins.nvim-tree")
require("ld.plugins.table-mode")
require("ld.plugins.vim-dadbod-ui")
require("ld.plugins.vim-wiki")
require("ld.plugins.workspace")
require("ld.plugins.polyglot")
require("ld.plugins.nvim-cmp")
require("ld.plugins.vim-vsnip")
