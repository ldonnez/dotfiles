local orgDestination = "~/SynologyDrive/org"


require("orgmode").setup_ts_grammar()
require("orgmode").setup({
  org_agenda_files = { orgDestination .. "/*", orgDestination .. "/**/*" },
  org_default_notes_file = orgDestination .. "/refile.org",
  org_agenda_templates = {
    t = { description = "Task", template = "\n* TODO %?\n %u", target = orgDestination .. "/todos.org" },
    j = {
      description = "Journal",
      template = "\n** %<%Y-%m-%d> %<%A>\n**** %U\n\n   %?",
      target = orgDestination .. "/journal.org",
    },
    b = {
      description = "Braindump",
      template = "** %U\n <%a>\n\n %?",
      target = orgDestination .. "/braindump.org",
    },
    s = {
      description = "Shopping list",
      template = " + [ ] %?",
      target = orgDestination .. "/shopping_list.org",
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "org",
  command = "setlocal nowrap",
})

vim.keymap.set("n", "<leader>og", ":edit" .. orgDestination .. "/index.org | :cd %:p:h<CR>:pwd<CR>", {
  noremap = true,
  silent = true,
})
