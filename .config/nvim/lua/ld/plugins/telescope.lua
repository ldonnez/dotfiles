local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--line-number",
      "--column",
      "--with-filename",
      "--smart-case",
      "--trim",
      "--no-ignore-vcs",
      "--hidden",
    },
    initial_mode = "insert",
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-[>"] = actions.close,
        ["<C-a>"] = actions.select_all,
      },
      n = {
        ["<C-[>"] = actions.close,
      },
    },
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    layout_strategy = "vertical",
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--hidden", "--no-ignore-vcs", "--type", "f" },
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
      },
    },
  },

  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    file_browser = {
      dir_icon = "",
      mappings = {
        i = {
          ["<C-y>"] = fb_actions.create,
          ["<C-d>"] = fb_actions.remove,
          ["<C-r>"] = fb_actions.rename,
          ["<C-o>"] = fb_actions.copy,
        },
      },
    },
  },
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

vim.api.nvim_set_keymap(
  "n",
  "<C-p>",
  "<cmd>lua require('telescope.builtin').find_files()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>b",
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>lg",
  "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>g",
  "<cmd>lua require('telescope.builtin').git_status()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>tl",
  "<cmd>lua require('telescope.builtin').builtin()<cr>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope file_browser <cr>", { noremap = true })
