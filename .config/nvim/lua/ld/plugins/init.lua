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
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("ld.lsp")
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    branch = "0.5-compat",
    config = function()
      require("ld.treesitter")
    end,
  })
  use({
    "thaerkh/vim-workspace",
    config = function()
      require("ld.plugins.workspace")
    end,
  })
  use({
    "mattn/emmet-vim",
    config = function()
      require("ld.plugins.emmet")
    end,
  })
  use("jiangmiao/auto-pairs")
  use("alvan/vim-closetag")
  use("tpope/vim-surround")
  use({
    "itchyny/lightline.vim",
    config = function()
      require("ld.plugins.lightline")
    end,
  })
  use({
    "vimwiki/vimwiki",
    config = function()
      require("ld.plugins.vim-wiki")
    end,
  })
  use({
    "arcticicestudio/nord-vim",
    config = function()
      require("ld.plugins.nord")
    end,
  })
  use({
    "junegunn/fzf.vim",
    config = function()
      require("ld.plugins.fzf")
    end,
    requires = {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end,
    },
  })
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("ld.plugins.gitsigns")
    end,
  })
  use("tpope/vim-dadbod")
  use({
    "kristijanhusak/vim-dadbod-ui",
    config = function()
      require("ld.plugins.vim-dadbod-ui")
    end,
  })
  use("pantharshit00/vim-prisma")
  use({
    "dhruvasagar/vim-table-mode",
    config = function()
      require("ld.plugins.table-mode")
    end,
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("ld.plugins.null-ls")
    end,
  })
  use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = { "nvim-lua/plenary.nvim" } })
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("ld.plugins.nvim-tree")
    end,
  })

  use({ "hrsh7th/vim-vsnip", requires = {
    "rafamadriz/friendly-snippets",
  } })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("ld.plugins.nvim-cmp")
      require("ld.plugins.vim-vsnip")
    end,
  })
  use({
    "sumneko/lua-language-server",
    run = global.is_unix and [[cd 3rd/luamake && compile/install.sh && cd ../.. && ./3rd/luamake/luamake rebuild]]
      or [[cd 3rd\luamake & compile\install.bat & cd ..\.. & 3rd\luamake\luamake.exe rebuild]],
  })
  use({
    "kristijanhusak/orgmode.nvim",
    requires = {
      "lukas-reineke/headlines.nvim",
      "akinsho/org-bullets.nvim",
    },
    config = function()
      require("ld.plugins.orgmode")
    end,
  })
end)
