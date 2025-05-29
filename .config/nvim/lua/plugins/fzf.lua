return {
  "ibhagwan/fzf-lua",
  config = function()
    local actions = require("fzf-lua.actions")

    require("fzf-lua").setup({
      "fzf-vim",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      previewers = {
        builtin = {
          snacks_image = { enabled = true, render_inline = false },
        },
      },
      winopts = {
        row = 0.2,
        height = 0.8,
        width = 0.8,
        treesitter = {
          enabled = true,
        },
        preview = {
          layout = "flex",
          vertical = "down:60%",
          horizontal = "right:40%",
          hidden = "nohidden",
        },
      },
      keymap = {
        fzf = {
          ["ctrl-a"] = "toggle-all",
        },
      },
      defaults = {
        actions = {
          ["ctrl-q"] = actions.file_sel_to_qf,
          ["ctrl-y"] = function(selected)
            local path = require("fzf-lua.path")
            local entry = path.entry_to_file(selected[1])

            if entry.path == "<none>" then
              return
            end

            vim.fn.setreg("+", entry.path)

            print("Copied to clipboard: " .. entry.path)
          end,
        },
      },
      files = {
        fd_opts = [[--type f --hidden --follow --no-ignore-vcs]],
        no_header_i = true,
      },
      grep = {
        rg_opts = [[--line-number --column --no-heading --color=always --with-filename --smart-case --trim --no-ignore-vcs --hidden]],
      },
    })

    require("fzf-lua").register_ui_select(function(_, items)
      return {
        winopts = {
          height = math.floor(math.min(vim.o.lines * 0.4, #items + 2) + 0.5),
          width = 0.5,
          relative = "cursor",
          row = 1,
          backdrop = 100,
          preview = { hidden = "hidden" },
        },
      }
    end)
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "FzfLua" },
  keys = {
    {
      "<C-p>",
      function()
        require("fzf-lua").files()
      end,

      desc = "Find files",
    },
    {
      "<leader>b",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>lg",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>g",
      function()
        require("fzf-lua").git_status()
      end,
      desc = "Show changed files (git)",
    },
    {
      "<leader>cr",
      function()
        require("fzf-lua").lsp_references()
      end,
      desc = "LSP References",
    },
  },
}
