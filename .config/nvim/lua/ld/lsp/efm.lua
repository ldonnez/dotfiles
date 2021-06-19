local lspconfig = require"lspconfig"

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

lspconfig.efm.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        if client.resolved_capabilities.document_formatting then
          vim.cmd("command -buffer Formatting lua vim.lsp.buf.formatting()")
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
        }
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
