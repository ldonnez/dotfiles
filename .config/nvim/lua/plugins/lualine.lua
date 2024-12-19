local M = {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true,
      section_separators = "",
      component_separators = "",
    },
    tabline = {
      lualine_a = {
        {
          "tabs",
          mode = 2,
          max_length = vim.o.columns,
          fmt = function(name, context)
            -- Show + if buffer is modified in tab
            local buflist = vim.fn.tabpagebuflist(context.tabnr)
            local winnr = vim.fn.tabpagewinnr(context.tabnr)
            local bufnr = buflist[winnr]
            local mod = vim.fn.getbufvar(bufnr, "&mod")

            return name .. (mod == 1 and " +" or "")
          end,
        },
      },
    },
    extensions = { "fugitive", "oil", "fzf" },
  })

  -- lualine overrides this option; makes sure tabline only shows when there are atleast 2 tabpages
  vim.opt.showtabline = 1
end

return M
