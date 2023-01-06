local M = {
  "lewis6991/gitsigns.nvim",
  cmd = { "Gitsigns" },
  event = { "BufReadPost" },
}

function M.config()
  require("gitsigns").setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
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
end

return M
