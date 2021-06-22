local lspconfig = require"lspconfig"
local utils = require"ld.lsp.utils"

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}
local prettier = {
    formatCommand = "prettier ${--config-precedence:configPrecedence} --stdin --stdin-filepath ${INPUT}",
    formatStdin = true
}

local efm_root_markers = { 'package.json', '.git/' }

lspconfig.efm.setup {
    on_attach = function(client)
        utils.on_attach(client)
        client.resolved_capabilities.document_formatting = true
        if client.resolved_capabilities.document_formatting then
          vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
        end
    end,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    init_options = {
        documentFormatting = true,
        codeAction = true
    },
    settings = {
        languages = {
            typescript = {prettier, eslint},
            typescriptreact = {prettier, eslint}
        },
        rootMarkers = efm_root_markers,
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    }
}
