vim.cmd.packadd("nvim.undotree")

local pack = require("pack")

require("plugins.treesitter")
require("plugins.lsp")

pack.load({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin", version = vim.version.range("*") } })

vim.cmd.colorscheme("catppuccin-frappe")

pack.load({ "https://github.com/nvim-tree/nvim-web-devicons" })

pack.load({ "https://github.com/rmagatti/auto-session" }, function()
  require("auto-session").setup({
    auto_save = true,
    allowed_dirs = { "~/projects", "~/projects/*", "~/config", "~/dotfiles" },
  })
end)

pack.load({
  { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
}, { events = { "InsertEnter", "CmdlineEnter" } }, function()
  local blink = require("blink.cmp")

  blink.setup({
    keymap = { preset = "enter" },
    cmdline = {
      keymap = { preset = "super-tab" },
      completion = { menu = { auto_show = true } },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "dadbod" },
        markdown = { inherit_defaults = true },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 0 },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true },
  })
end)

pack.load({ "https://github.com/ibhagwan/fzf-lua" }, {
  commands = { "Fzf", "FzfLua" },
  keymaps = {
    {
      "n",
      "<C-p>",
      function()
        require("fzf-lua").files()
      end,
      { desc = "Find files" },
    },
    {
      "n",
      "<leader>b",
      function()
        require("fzf-lua").buffers()
      end,
      { desc = "Find buffers" },
    },
    {
      "n",
      "<leader>lg",
      function()
        require("fzf-lua").live_grep()
      end,
      { desc = "Live grep" },
    },
  },
}, function()
  local actions = require("fzf-lua.actions")

  require("fzf-lua").setup({
    "fzf-vim",
    fzf_colors = true,
    fzf_opts = { ["--no-scrollbar"] = true },
    previewers = { builtin = { snacks_image = { enabled = true, render_inline = false } } },
    winopts = {
      row = 0.2,
      height = 0.8,
      width = 0.8,
      treesitter = { enabled = true },
      preview = { layout = "flex", vertical = "down:60%", horizontal = "right:40%", hidden = "nohidden" },
    },
    keymap = { fzf = { ["ctrl-a"] = "toggle-all" } },
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
    files = { fd_opts = [[--type f --hidden --follow --no-ignore-vcs]], no_header_i = true },
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
end)

pack.load({ { src = "https://github.com/stevearc/conform.nvim", version = vim.version.range("*") } }, {
  keymaps = {
    {
      { "n", "v" },
      "<leader>f",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      { desc = "Format" },
    },
  },
}, function()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      sql = { "sqlfmt" },
      terraform = { "terraform_fmt" },
      bash = { "shfmt" },
      go = { "gofmt" },
      xml = { "xmllint" },
      http = { "kulala-fmt" },
      rest = { "kulala-fmt" },
    },
  })
end)

pack.load({ "https://github.com/lewis6991/gitsigns.nvim" }, { events = { "BufReadPre" } }, function()
  local gs = require("gitsigns")

  gs.setup({
    on_attach = function(bufnr)
      local keymap = vim.keymap

      keymap.set(
        { "n", "v" },
        "<leader>hr",
        ":Gitsigns reset_hunk<CR>",
        { silent = true, buffer = bufnr, desc = "Reset hunk" }
      )
      keymap.set(
        { "n", "v" },
        "<leader>hs",
        ":Gitsigns stage_hunk<CR>",
        { silent = true, buffer = bufnr, desc = "Stage hunk" }
      )

      keymap.set("n", "<leader>hS", gs.stage_buffer, { silent = true, buffer = bufnr, desc = "Stage buffer" })
      keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { silent = true, buffer = bufnr, desc = "Undo stage hunk" })
      keymap.set("n", "<leader>hR", gs.reset_buffer, { silent = true, buffer = bufnr, desc = "Reset buffer" })
      keymap.set("n", "<leader>hp", gs.preview_hunk, { silent = true, buffer = bufnr, desc = "Preview hunk" })
      keymap.set("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, { buffer = bufnr, desc = "Blame line" })
      keymap.set(
        "n",
        "<leader>htb",
        gs.toggle_current_line_blame,
        { silent = true, buffer = bufnr, desc = "Toggle current line blame" }
      )
      keymap.set("n", "<leader>hd", gs.diffthis, { silent = true, buffer = bufnr, desc = "Diff current line" })
      keymap.set("n", "<leader>hD", function()
        gs.diffthis("~")
      end, { silent = true, buffer = bufnr, desc = "Diff current file" })
      keymap.set("n", "<leader>htd", gs.toggle_deleted, { silent = true, buffer = bufnr, desc = "Toggle deleted" })
      keymap.set(
        "n",
        "<leader>ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        { silent = true, buffer = bufnr, desc = "Visual select hunk" }
      )
      keymap.set("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { silent = true, buffer = bufnr, desc = "Go to next hunk" })
      keymap.set("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { silent = true, buffer = bufnr, desc = "Go to next hunk" })
    end,
  })
end)

pack.load({ "https://github.com/nvim-lualine/lualine.nvim" }, { events = { "BufReadPre", "BufNewFile" } }, function()
  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true,
      section_separators = "",
      component_separators = "",
      always_show_tabline = false,
    },
    tabline = {
      lualine_a = {
        {
          "tabs",
          mode = 2,
          max_length = vim.o.columns,
          fmt = function(name, context)
            local buflist = vim.fn.tabpagebuflist(context.tabnr)
            local winnr = vim.fn.tabpagewinnr(context.tabnr)
            local bufnr = buflist[winnr]
            local mod = vim.fn.getbufvar(bufnr, "&mod")
            return name .. (mod == 1 and " +" or "")
          end,
        },
      },
    },
    extensions = { "fugitive", "oil", "fzf", "quickfix" },
  })
end)

pack.load({
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("*") },
})

pack.load({ "https://github.com/windwp/nvim-autopairs" }, { events = { "InsertEnter" } }, function()
  require("nvim-autopairs").setup()
end)

pack.load({ { src = "https://github.com/stevearc/oil.nvim", version = vim.version.range("*") } }, {
  keymaps = {
    {
      "n",
      "<C-e>",
      function()
        require("oil").open(vim.fn.getcwd())
      end,
      { desc = "Open cwd" },
    },
    {
      "n",
      "<leader>n",
      function()
        require("oil").open()
      end,
      { desc = "Open file" },
    },
  },
}, function()
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
      ["<C-p>"] = false,
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
end)

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_save_location = "~/SynologyDrive/development/saved_queries"

pack.load({
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/pbogut/vim-dadbod-ssh",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
}, { commands = { "DBUI" } })

pack.load({ "https://github.com/tpope/vim-fugitive" }, { commands = { "G", "Git" } })

pack.load({ "https://github.com/dhruvasagar/vim-table-mode" }, {
  commands = {
    "TableModeToggle",
  },
  keymaps = {
    {
      "n",
      "<leader>tm",
      ":TableModeToggle",
      { desc = "Toggle table mode" },
    },
  },
}, function()
  vim.g.table_mode_corner = "+"
end)

pack.load({ "https://github.com/folke/which-key.nvim" }, function()
  require("which-key").setup({ preset = "modern", show_help = false })
end)

pack.load({ "https://github.com/brenoprata10/nvim-highlight-colors" }, { events = { "BufReadPre" } }, function()
  require("nvim-highlight-colors").setup()
end)

pack.load({ "https://github.com/mfussenegger/nvim-ansible" }, { filetypes = { "yaml", "yaml.ansible" } })

pack.load(
  { { src = "https://github.com/folke/snacks.nvim", version = vim.version.range("*") } },
  { events = { "BufReadPost" } },
  function()
    require("snacks").setup({ input = {}, image = {} })
  end
)

pack.load(
  { { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", version = vim.version.range("*") } },
  { filetypes = { "markdown" } },
  function()
    require("render-markdown").setup({
      completions = { blink = { enabled = true } },
      latex = { enabled = false },
      indent = { enabled = true },
    })
  end
)

pack.load({ { src = "https://github.com/ldonnez/memo.nvim", version = vim.version.range("*") } })

vim.keymap.set("n", "<leader>mc", function()
  require("memo").register_capture({
    capture_file = "braindump.md.gpg",
    capture_template = { target_header = "# " .. os.date("%Y-%m-%d"), header_padding = 1 },
  })
end, { desc = "Capture to braindump" })
vim.keymap.set("n", "<leader>mf", function()
  require("memo.pickers.fzf_lua").files_picker()
end, { desc = "Memo files picker" })
vim.keymap.set("n", "<leader>ms", function()
  require("memo").sync_git()
end, { desc = "Sync with git" })
vim.keymap.set("n", "<leader>mt", function()
  require("memo.pickers.fzf_lua").current_buffer_todo_picker("todo")
end, { desc = "Find TODOs in buffer" })
vim.keymap.set("n", "<leader>ma", function()
  require("memo.pickers.fzf_lua").current_buffer_todo_picker("all")
end, { desc = "Find all TODOs in buffer" })
vim.keymap.set("n", "<leader>md", function()
  require("memo.pickers.fzf_lua").current_buffer_todo_picker("done")
end, { desc = "Find done TODOs in buffer" })

pack.load({
  { src = "https://github.com/mistweaverco/kulala.nvim", version = vim.version.range("*") },
}, { filetypes = { "http", "rest" } }, function()
  vim.treesitter.start(vim.api.nvim_get_current_buf(), "kulala_http")

  require("kulala").setup({
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    vscode_rest_client_environmentvars = true,
  })
end)

pack.load({ "https://github.com/sindrets/diffview.nvim" }, {
  commands = { "DiffviewOpen", "DiffviewFileHistory" },
  keymaps = {
    { "n", "<leader>dvo", ":DiffviewOpen <CR>", { desc = "Open diff view" } },
    { "n", "<leader>dvf", ":DiffviewFileHistory % <CR>", { desc = "Current file history" } },
    { "n", "<leader>dvb", ":DiffviewFileHistory <CR>", { desc = "Branch history" } },
    { "n", "<leader>dvc", ":DiffviewClose", { desc = "Close" } },
  },
})
