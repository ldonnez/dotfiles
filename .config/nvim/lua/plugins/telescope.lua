local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "stevearc/dressing.nvim",
      version = "*",
      opts = {
        select = {
          telescope = require("telescope.themes").get_cursor(),
        },
      },
    },
  },
  cmd = { "Telescope" },
  keys = {
    {
      "<C-p>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files",
    },
    {
      "<leader>b",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>lg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>g",
      function()
        require("telescope.builtin").git_status()
      end,
      desc = "Show changed files (git)",
    },
    {
      "<leader>tl",
      function()
        require("telescope.builtin").builtin()
      end,
      desc = "Show all telescope pickers",
    },
    {
      "<leader>tb",
      function()
        require("telescope").extensions.file_browser.file_browser()
      end,
      desc = "Open file browser",
    },
    {
      "<leader>tn",
      function()
        require("telescope").extensions.file_browser.file_browser({
          path = "%:p:h",
          select_buffer = true,
        })
      end,
      desc = "Open file browser current file",
    },
    {
      "<leader>tp",
      function()
        require("telescope").extensions.persisted.persisted()
      end,
      desc = "Show sessions from persisted",
    },
  },
}

function M.config()
  local actions = require("telescope.actions")
  local fb_actions = require("telescope").extensions.file_browser.actions

  local layout_config = {
    mirror = true,
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
          ["<C-a>"] = actions.select_all,
          ["<C-y>"] = function(_)
            local entry = require("telescope.actions.state").get_selected_entry()
            if entry ~= nil then
              local content = entry.path
              local relative_path = vim.fn.fnamemodify(content, ":~:.")

              vim.fn.setreg("+", relative_path)

              print("Copied to clipboard: " .. relative_path)
            end
          end,
        },
      },
      layout_strategy = "vertical",
    },
    pickers = {
      find_files = {
        layout_config = layout_config,
        find_command = { "fd", "--hidden", "--no-ignore-vcs", "--follow", "--type", "f" },
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
        sort_mru = true,
        ignore_current_buffer = true,
        cwd_only = true,
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
        theme = "ivy",
        layout_config = {
          prompt_position = "bottom",
        },
        hijack_netrw = true,
        no_ignore = true,
        hidden = true,
        auto_depth = true,
        respect_gitignore = false,
        mappings = {
          i = {
            ["<C-x>"] = fb_actions.move,
            ["<C-p>"] = fb_actions.copy,
            ["<C-d>"] = fb_actions.remove,
            ["<C-r>"] = fb_actions.rename,
            ["<C-c>"] = fb_actions.create,
          },
        },
      },
    },
  })
  -- To get fzf loaded and working with telescope, you need to call
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("persisted")
end

return M
