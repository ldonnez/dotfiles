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
  formatCommand = './node_modules/.bin/prettier --stdin --stdin-filepath ${INPUT}',
  formatStdin = true,
  rootMarkers = {'package.json'}
}

local prettierGlobal = {
  formatCommand = 'prettier --stdin --stdin-filepath ${INPUT}',
  formatStdin = true
}

local stylua = { formatCommand = 'stylua -s -', formatStdin = true }

lspconfig.efm.setup {
    on_attach = function(client)
        utils.on_attach(client)
        client.resolved_capabilities.document_formatting = true
        if client.resolved_capabilities.document_formatting then
          utils.buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { noremap=true, silent=true })
        end
    end,
    root_dir = lspconfig.util.root_pattern({ '.git/', '.' }),
    init_options = {
        documentFormatting = true,
        codeAction = false
    },
    settings = {
        languages = {
            typescript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            json = {prettierGlobal},
            html = {prettier},
            markdown = {prettierGlobal},
            yaml = {prettierGlobal},
            vimwiki = {prettierGlobal},
            lua = { stylua },
        }
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "typescript.tsx",
        "json",
        "html",
        "markdown",
        "yaml",
        "vimkwiki",
        "lua"
    }
}
