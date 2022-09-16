vim.g.catppuccin_flavour = "frappe"

require("catppuccin").setup({
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    coc_nvim = false,
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = true,
    dap = {
      enabled = false,
      enable_ui = false,
    },
    neotree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    markdown = true,
    lightspeed = false,
    leap = false,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = false,
    symbols_outline = false,
    mini = false,
    aerial = false,
    vimwiki = false,
    beacon = false,
    navic = {
      enabled = false,
      custom_bg = "NONE",
    },
    overseer = false,
    fidget = false,
    treesitter_context = false,
  },
})

vim.cmd([[
  silent! colorscheme catppuccin
]])
