local global = require("ld.global")

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

local use = require("packer").use
require("packer").startup(function()
  use("wbthomason/packer.nvim")

  -- Theme
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("ld.plugins.catppuccin")
    end,
  })

  -- Icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    opt = true,
  })

  -- Plenary a plugin that is used by a lot of plugins
  use({
    "nvim-lua/plenary.nvim",
    module = "plenary",
  })

  -- Easy Git integration
  use({ "tpope/vim-fugitive", cmd = { "G", "Git" } })

  -- Git signs on the left side of the numbers
  use({
    "lewis6991/gitsigns.nvim",
    tag = "release",
    config = function()
      require("ld.plugins.gitsigns")
    end,
  })

  -- Git history of commits and file history view
  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = { { "n", "<leader>dvf" } },
    config = function()
      require("ld.plugins.diffview")
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
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "kristijanhusak/vim-dadbod-completion", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
    },
    config = function()
      require("ld.plugins.nvim-cmp")
    end,
  })

  -- Fuzzy searching/grepping through files
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
    module = "telescope",
    cmd = { "Telescope" },
    keys = {
      { "n", "<C-p>" },
      { "n", "<leader>b" },
      { "n", "<leader>lg" },
      { "n", "<leader>g" },
      { "n", "<leader>tl" },
      { "n", "<leader>fb" },
    },
    config = function()
      require("ld.plugins.telescope")
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
    config = function()
      require("ld.treesitter")
    end,
  })

  -- Save sessions & restore buffers for projects
  use({
    "olimorris/persisted.nvim",
    config = function()
      require("ld.plugins.persisted")
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
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("ld.plugins.autopairs")
    end,
  })

  -- Surround everything
  use({
    "kylechui/nvim-surround",
    event = "BufRead",
    config = function()
      require("ld.plugins.surround")
    end,
  })

  -- Better statusline
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("ld.plugins.lualine")
    end,
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

  -- File tree
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
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
    config = function()
      require("ld.plugins.orgmode")
    end,
    requires = {
      { "akinsho/org-bullets.nvim" },
    },
  })
end)
