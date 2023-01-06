local M = {
  "nvim-orgmode/orgmode",
  ft = "org",
  event = "VeryLazy",
  dependencies = {
    { "akinsho/org-bullets.nvim" },
    { "nvim-treesitter" },
  },
}

function M.config()
  local orgDestination = "~/org"

  require("orgmode").setup_ts_grammar()
  require("orgmode").setup({
    org_agenda_files = { orgDestination .. "/*", orgDestination .. "/**/*" },
    org_default_notes_file = orgDestination .. "/refile.org",
    org_agenda_templates = {
      i = "INBOX",
      it = {
        description = "Todo",
        template = "** TODO %?\n %u",
        target = orgDestination .. "/INBOX.org",
        headline = "TODO's",
      },
      ib = {
        description = "Braindump",
        template = "** %U %?\n <%a>\n\n ",
        target = orgDestination .. "/INBOX.org",
      },
      j = {
        description = "Journal",
        template = "* %<%Y-%m-%d> %<%A>\n**** %U\n\n   %?",
        target = orgDestination .. "/journal.org",
      },
      s = "Shopping",
      sd = {
        description = "Delhaize",
        template = "+ [ ] %?",
        target = orgDestination .. "/shopping_list.org",
        headline = "Delhaize",
      },
      si = {
        description = "Ikea",
        template = "+ [ ] %?",
        target = orgDestination .. "/shopping_list.org",
        headline = "Ikea",
      },
      sa = {
        description = "Aldi",
        template = "+ [ ] %?",
        target = orgDestination .. "/shopping_list.org",
        headline = "Aldi",
      },
      sl = {
        description = "Lidl",
        template = "+ [ ] %?",
        target = orgDestination .. "/shopping_list.org",
        headline = "Lidl",
      },
      z = "Books",
      zw = {
        description = "Wishlist",
        template = "  + [ ] %?",
        target = orgDestination .. "/books.org",
        headline = "Books",
      },
      za = {
        description = "Authors to check",
        template = "  - %?",
        target = orgDestination .. "/books.org",
        headline = "Authors",
      },
    },
    mappings = {
      org = {
        org_timestamp_up = "+",
        org_timestamp_down = "-",
        org_refile = false,
      },
    },
    notifications = {
      enabled = true,
      reminder_time = { 0, 5, 10, 30, 60 },
    },
  })
  require("org-bullets").setup()

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "org",
    command = "setlocal nowrap",
  })

  -- Replace refile prompt with telescope
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "org",
    group = vim.api.nvim_create_augroup("orgmode_telescope_nvim", { clear = true }),
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>or",
        require("telescope").extensions.orgmode.refile_heading,
        { silent = true, desc = "org refile" }
      )
    end,
  })
end

return M
