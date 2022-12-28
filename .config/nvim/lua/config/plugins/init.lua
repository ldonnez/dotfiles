local global = require("config.global")

return {
  "nvim-lua/plenary.nvim",
  "folke/neodev.nvim",
  { "kyazdani42/nvim-web-devicons" },
  {
    "sumneko/lua-language-server",
    build = global.is_unix and [[cd 3rd/luamake && compile/install.sh && cd ../.. && ./3rd/luamake/luamake rebuild]]
      or [[cd 3rd\luamake & compile\install.bat & cd ..\.. & 3rd\luamake\luamake.exe rebuild]],
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("config.lsp")
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>" },
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
  },
  {
    "mattn/emmet-vim",
    keys = { "<C-y>", { "<C-y>", "i" } },
    ft = { "javascript", "javascriptreact", "typescriptreact", "html", "typescript" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "BufRead",
    keys = { "cs", "ds", "ys" },
    config = true,
  },
  { "tpope/vim-fugitive", cmd = { "G", "Git" } },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI" },
    dependencies = {
      { "tpope/vim-dadbod" },
    },
    config = function()
      vim.g.db_ui_save_location = "~/SynologyDrive/development/saved_queries"
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    cmd = { "TableModeToggle" },
    keys = { "<Leader>tm" },
    config = function()
      vim.g.table_mode_corner = "+"
    end,
  },
}
