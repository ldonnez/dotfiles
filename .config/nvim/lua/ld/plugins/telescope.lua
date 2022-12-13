local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

local layout_config = {
  mirror = true,
  prompt_position = "top",
}

local dropdown_layout_config = {
  prompt_position = "top",
}

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
    layout_strategy = "vertical",
  },
  pickers = {
    find_files = {
      layout_config = layout_config,
      find_command = { "fd", "--hidden", "--no-ignore-vcs", "--type", "f" },
    },
    live_grep = {
      layout_config = layout_config,
    },
    lsp_references = {
      layout_config = layout_config,
      show_line = false,
    },
    buffers = {
      layout_config = layout_config,
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
    ["ui-select"] = {
      require("telescope.themes").get_cursor({
        layout_config = dropdown_layout_config,
      }),
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
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("persisted")

vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end, { silent = true, desc = "Find files" })

vim.keymap.set("n", "<leader>b", function()
  require("telescope.builtin").buffers()
end, { silent = true, desc = "Find buffers" })

vim.keymap.set("n", "<leader>lg", function()
  require("telescope.builtin").live_grep()
end, { silent = true, desc = "Live grep" })

vim.keymap.set("n", "<leader>g", function()
  require("telescope.builtin").git_status()
end, { desc = "Show changed files (git)" })

vim.keymap.set("n", "<leader>tl", function()
  require("telescope.builtin").builtin()
end, { desc = "Show all telescope pickers" })

vim.keymap.set("n", "<leader>fb", function()
  require("telescope").extensions.file_browser.file_browser()
end, { desc = "Open file browser" })

vim.keymap.set("n", "<leader>tp", function()
  require("telescope").extensions.persisted.persisted()
end, { desc = "Show sessions from persisted" })
