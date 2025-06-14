return {
  { "folke/lazy.nvim", version = "*" },
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "folke/which-key.nvim",
    version = "*",
    opts = {
      preset = "modern",
      show_help = false,
    },
    event = { "BufReadPre", "BufNewFile" },
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
    version = "*",
    keys = {
      { "cs", desc = "Change surrounding pair" },
      { "ds", desc = "Delete surrounding pair" },
      { "ys", desc = "Add a surrounding pair around a motion (normal mode)" },
    },
    opts = {},
  },
  { "tpope/vim-fugitive", cmd = { "G", "Git" } },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI" },
    dependencies = {
      { "tpope/vim-dadbod" },
      { "pbogut/vim-dadbod-ssh" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
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
    opts = {},
  },
  {
    "olimorris/persisted.nvim",
    version = "*",
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
    event = "BufReadPre",
    opts = {},
  },
  {
    "folke/snacks.nvim",
    version = "*",
    lazy = false,
    priority = 1000,
    opts = {
      input = {},
      image = {},
    },
  },
}
