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
    "rmagatti/auto-session",
    lazy = false,
    priority = 2000,
    opts = {
      auto_save = true,
      allowed_dirs = { "~/projects/*", "~/config", "~/dotfiles" },
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
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    version = "*",
    ft = { "markdown" },
    opts = {
      completions = { blink = { enabled = true } },
      latex = { enabled = false },
      indent = { enabled = true },
    },
  },
  {
    "ldonnez/memo.nvim",
    version = "*",
    event = { "VeryLazy" },
    opts = {
      notes_dir = "~/notes",
    },
    keys = {
      {
        "<leader>mc",
        function()
          require("memo").register_capture({
            capture_file = "braindump.md.gpg",
            capture_template = {
              target_header = "# " .. os.date("%Y-%m-%d"),
              header_padding = 1,
            },
          })
        end,
        desc = "Capture to braindump",
      },
      {
        "<leader>mf",
        function()
          require("memo").fzf_lua_picker()
        end,
        desc = "Memo files picker",
      },
      {
        "<leader>ms",
        function()
          require("memo").sync_git()
        end,
        desc = "Sync with git",
      },
    },
  },
}
