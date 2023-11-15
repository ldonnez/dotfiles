local M = {
  "stevearc/oil.nvim",
  cmd = { "Oil" },
  version = "*",
  keys = {
    {
      "<C-e>",
      function()
        require("oil").open(vim.fn.getcwd())
      end,
      mode = { "n" },
      desc = "Open Oil current working dir",
    },
    {
      "<leader>n",
      function()
        require("oil").open()
      end,
      mode = { "n" },
      desc = "Open Oil current file",
    },
  },
}

function M.config()
  local function get_selected_file_path()
    local entry = require("oil").get_cursor_entry()
    local dir = require("oil").get_current_dir()
    if entry ~= nil and dir ~= nil then
      return dir .. entry.name
    end
  end

  require("oil").setup({
    keymaps = {
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["Y"] = function()
        local file_path = get_selected_file_path()
        if file_path then
          local relative_path = vim.fn.fnamemodify(file_path, ":~:.")

          vim.fn.setreg("+", relative_path)

          print("Copied to clipboard: " .. relative_path)
        end
      end,
      ["YY"] = function()
        local file_path = get_selected_file_path()
        if file_path then
          vim.fn.setreg("+", file_path)

          print("Copied to clipboard: " .. file_path)
        end
      end,
    },
  })
end

return M
