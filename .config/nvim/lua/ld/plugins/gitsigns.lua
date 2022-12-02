require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns stage_hunk<CR>", { buffer = bufnr, desc = "Reset hunk" })
    vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { buffer = bufnr, desc = "Stage hunk" })
    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
    vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
    vim.keymap.set("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, { buffer = bufnr, desc = "Blame line" })
    vim.keymap.set(
      "n",
      "<leader>htb",
      gs.toggle_current_line_blame,
      { buffer = bufnr, desc = "Toggle current line blame" }
    )
    vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff current line" })
    vim.keymap.set("n", "<leader>hD", function()
      gs.diffthis("~")
    end, { buffer = bufnr, desc = "Diff current file" })
    vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
    vim.keymap.set("n", "<leader>ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Visual select hunk" })
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { buffer = bufnr, desc = "Go to next hunk" })
    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { buffer = bufnr, desc = "Go to next hunk" })
  end,
})
