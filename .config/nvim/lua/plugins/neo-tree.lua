local M = {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    { "<C-e>", "<cmd>Neotree toggle<CR>", silent = true, desc = "Open neotree" },
    { "<leader>n", "<cmd>Neotree filesystem reveal left<CR>", silent = true, desc = "Open neotree current file" },
  },
  version = "*",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "*",
      opts = {
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
          },
        },
        other_win_hl_color = "#54AEFF",
      },
    },
  },
}

function M.config()
  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

  require("neo-tree").setup({
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
    },
    window = {
      position = "left",
      mappings = {
        ["<cr>"] = "open_with_window_picker",
        ["<C-x>"] = "split_with_window_picker",
        ["<C-v>"] = "vsplit_with_window_picker",
        ["<C-t>"] = "open_tabnew",
        ["Y"] = function(state)
          local node = state.tree:get_node()
          local content = node.path:gsub(state.path:gsub("[%-_^$.*+-?]", "%%%0"), ""):sub(2)
          vim.fn.setreg('"', content)
          vim.fn.setreg("1", content)
          vim.fn.setreg("+", content)
        end,
      },
    },
  })
end

return M
