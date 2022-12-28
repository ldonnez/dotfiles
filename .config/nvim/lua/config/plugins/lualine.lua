return {
  "nvim-lualine/lualine.nvim",
  event = { "BufRead" },
  config = function()
    require("lualine").setup({
      options = { theme = "catppuccin", globalstatus = true },
    })
  end,
}
