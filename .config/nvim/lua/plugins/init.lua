return {
  { "folke/lazy.nvim", version = "*" },
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "mattn/emmet-vim",
    keys = { "<C-y>", { "<C-y>", mode = "i" } },
    ft = { "javascript", "javascriptreact", "typescriptreact", "html", "typescript" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
  {
    "kylechui/nvim-surround",
    keys = {
      { "cs", desc = "Change surrounding pair" },
      { "ds", desc = "Delete surrounding pair" },
      { "ys", desc = "Add a surrounding pair around a motion (normal mode)" },
    },
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
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>dvo", ":DiffviewOpen <CR>", silent = true, desc = "Diff view open" },
      { "<leader>dvf", ":DiffviewFileHistory % <CR>", silent = true, desc = "Current file history" },
      { "<leader>dvb", ":DiffviewFileHistory <CR>", silent = true, desc = "Current branch history" },
      { "<leader>dvc", ":DiffviewClose <CR>", silent = true, desc = "Close" },
    },
    config = true,
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,
    priority = 2000,
    opts = {
      autoload = true,
      allowed_dirs = {
        "~/projects",
        "~/config",
        "~/dotfiles",
      },
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = true,
  },
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        scss = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
      },
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format",
      },
    },
  },
}
