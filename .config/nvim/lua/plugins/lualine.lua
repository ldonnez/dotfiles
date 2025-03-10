return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
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
    extensions = { "fugitive", "oil", "fzf", "quickfix" },
  },
}
