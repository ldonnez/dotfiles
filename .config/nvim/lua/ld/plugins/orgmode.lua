local orgDestination = "~/SynologyDrive/org"
require("headlines").setup()
require("org-bullets").setup({})
require("orgmode").setup({
  org_agenda_files = { orgDestination .. "/*", orgDestination .. "/**/*" },
  org_default_notes_file = orgDestination .. "/refile.org",
  org_agenda_templates = {
    t = { description = "Task", template = "\n* TODO %?\n %u", target = orgDestination .. "/todos.org" },
    j = {
      description = "Journal",
      template = "\n** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
      target = orgDestination .. "/journal.org",
    },
    b = {
      description = "Braindump",
      template = "\n** %U \n<%a>\n\n%?",
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
      org_increase_date = "+",
      org_decrease_date = "-",
    },
  },
})

vim.api.nvim_set_keymap("n", "<leader>og", ":edit" .. orgDestination .. "/index.org | :cd %:p:h<CR>:pwd<CR>", { noremap = true, silent = true })
