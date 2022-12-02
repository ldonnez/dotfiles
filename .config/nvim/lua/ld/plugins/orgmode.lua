local orgDestination = "~/org"

require("orgmode").setup_ts_grammar()
require("orgmode").setup({
  org_agenda_files = { orgDestination .. "/*", orgDestination .. "/**/*" },
  org_default_notes_file = orgDestination .. "/refile.org",
  org_agenda_templates = {
    t = "Todo",
    tp = {
      description = "Personal",
      template = "** TODO %?\n %u",
      target = orgDestination .. "/todos.org",
      headline = "Personal",
    },
    tw = {
      description = "Work",
      template = "** TODO %?\n %u",
      target = orgDestination .. "/todos.org",
      headline = "Work",
    },
    j = {
      description = "Journal",
      template = "* %<%Y-%m-%d> %<%A>\n**** %U\n\n   %?",
      target = orgDestination .. "/journal.org",
    },
    b = {
      description = "Braindump",
      template = "* %U\n <%a>\n\n %?",
      target = orgDestination .. "/braindump.org",
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
