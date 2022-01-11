local lspconfig = require("lspconfig")
local utils = require("ld.lsp.utils")

lspconfig.tsserver.setup({
  capabilities = utils.cmp_capababilities(),
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,
      import_all_timeout = 5000, -- ms

      -- eslint
      eslint_enable_code_actions = false,
      eslint_enable_disable_comments = false,
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = false,

      -- formatting
      enable_formatting = false,
      formatter = "prettier",
      formatter_config_fallback = nil,

      -- parentheses completion
      complete_parens = false,
      signature_help_in_parens = false,

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = true,
      watch_dir = nil,
    })

    -- required to fix code action ranges
    ts_utils.setup_client(client)

    utils.on_attach(client, bufnr)
    utils.buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", { silent = true })
    utils.buf_set_keymap(bufnr, "n", "<leader>qf", ":TSLspFixCurrent<CR>", { silent = true })
    utils.buf_set_keymap(bufnr, "n", "<leader>gr", ":TSLspRenameFile<CR>", { silent = true })
    utils.buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", { silent = true })
  end,
})
