local pack = require("pack")

pack.load({
  { "https://github.com/nvim-treesitter/nvim-treesitter" },
  setup = function()
    local ts = require("nvim-treesitter")
    ts.install({
      "javascript",
      "typescript",
      "html",
      "css",
      "tsx",
      "vim",
      "vimdoc",
      "lua",
      "json",
      "yaml",
      "prisma",
      "graphql",
      "http",
      "markdown",
      "markdown_inline",
      "haskell",
      "sql",
      "terraform",
      "go",
      "bash",
      "xml",
      "make",
      "muttrc",
    })

    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
    local ignore_filetypes = { "checkhealth", "lazy", "json", "csv", "zsh" }

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(event)
        if vim.tbl_contains(ignore_filetypes, event.match) then
          return
        end
        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf
        pcall(vim.treesitter.start, buf, lang)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        if vim.list_contains(ts.get_available(), vim.treesitter.language.get_lang(event.match)) then
          ts.install({ lang })
        end
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})
