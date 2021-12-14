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

  -- Easy Git integration
  use({ "tpope/vim-fugitive", cmd = { "G", "Git" } })

  -- Git signs on the left side of the numbers
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("ld.plugins.gitsigns")
    end,
  })

  -- Snippets
  use({
    "hrsh7th/vim-vsnip",
    config = function()
      require("ld.plugins.vim-vsnip")
    end,
    requires = {
      "rafamadriz/friendly-snippets",
    },
  })

  -- Autocompletion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
      { "kristijanhusak/vim-dadbod-completion", after = "nvim-cmp" },
    },
    config = function()
      require("ld.plugins.nvim-cmp")
    end,
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("ld.lsp")
    end,
  })

  -- Highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    branch = "0.5-compat",
    config = function()
      require("ld.treesitter")
    end,
  })

  -- Save sessions & restore buffers for projects
  use({
    "thaerkh/vim-workspace",
    event = "BufEnter",
    config = function()
      require("ld.plugins.workspace")
    end,
  })

  -- Easy HTML/JSX
  use({
    "mattn/emmet-vim",
    keys = { { "n", "<C-y>" }, { "i", "<C-y>" } },
    ft = { "javascript", "javascriptreact", "typescriptreact", "html", "typescript" },
    config = function()
      require("ld.plugins.emmet")
    end,
  })

  -- Auto pair parentheses, brackets, quotes...
  use({ "jiangmiao/auto-pairs", event = "BufRead" })

  -- Surround everything
  use({ "tpope/vim-surround", event = "BufRead" })

  -- Theme
  use({
    "arcticicestudio/nord-vim",
    config = function()
      require("ld.plugins.nord")
    end,
  })

  -- Better statusline
  use({
    "itchyny/lightline.vim",
    after = "nord-vim",
    config = function()
      require("ld.plugins.lightline")
    end,
  })

  -- Fast fuzzy searching everything
  use({
    "junegunn/fzf.vim",
    cmd = { "Files", "Buffers", "GFiles" },
    keys = { { "n", "<C-p>" }, { "n", "<leader>b" }, { "n", "<leader>g" } },
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

  -- Nice database UI
  use({
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI" },
    requires = {
      { "tpope/vim-dadbod", after = "vim-dadbod-ui" },
    },
    config = function()
      require("ld.plugins.vim-dadbod-ui")
    end,
  })

  -- Prisma syntax highlighting
  use({ "pantharshit00/vim-prisma", ft = "prisma" })

  -- Create tables in markdown/org
  use({
    "dhruvasagar/vim-table-mode",
    cmd = { "TableModeToggle" },
    keys = { "n", "<Leader>tm" },
    config = function()
      require("ld.plugins.table-mode")
    end,
  })

  -- Generic language server in lua
  use({
    "jose-elias-alvarez/null-ls.nvim",
    keys = { "n", "<Leader>f" },
    ft = { "lua", "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "yaml" },
    config = function()
      require("ld.plugins.null-ls")
    end,
  })

  -- Improves typescripts language server enables supports file renames and auto imports
  use({
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
    after = "nvim-lspconfig",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- File tree
  use({
    "kyazdani42/nvim-tree.lua",
    event = "BufEnter",
    keys = { { "n", "<C-e>" }, { "n", "<leader>n" } },
    config = function()
      require("ld.plugins.nvim-tree")
    end,
  })

  -- Lua language server
  use({
    "sumneko/lua-language-server",
    opt = true,
    run = global.is_unix and [[cd 3rd/luamake && compile/install.sh && cd ../.. && ./3rd/luamake/luamake rebuild]]
      or [[cd 3rd\luamake & compile\install.bat & cd ..\.. & 3rd\luamake\luamake.exe rebuild]],
  })

  -- Org mode
  use({
    "nvim-orgmode/orgmode",
    requires = {
      { "lukas-reineke/headlines.nvim" },
      { "akinsho/org-bullets.nvim" },
    },
    config = function()
      require("ld.plugins.orgmode")
    end,
  })
end)
