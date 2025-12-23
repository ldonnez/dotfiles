local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  branch = "main",
}

function M.config()
  local ts = require("nvim-treesitter")
  local autocmd = vim.api.nvim_create_autocmd

  -- Install core parsers at startup
  ts.install({
    "javascript",
    "typescript",
    "html",
    "css",
    "tsx",
    "vim",
    "lua",
    "json",
    "jsonc",
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

  local ignore_filetypes = {
    "checkhealth",
    "lazy",
    "json",
  }

  -- Auto-install parsers and enable highlighting on FileType
  autocmd("FileType", {
    group = group,
    desc = "Enable treesitter highlighting and indentation",
    callback = function(event)
      if vim.tbl_contains(ignore_filetypes, event.match) then
        return
      end

      local lang = vim.treesitter.language.get_lang(event.match) or event.match
      local buf = event.buf

      -- Start highlighting immediately (works if parser exists)
      pcall(vim.treesitter.start, buf, lang)

      -- Enable treesitter indentation
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      -- Install missing parsers (async, no-op if already installed)
      ts.install({ lang })
    end,
  })
end

return M
