local global = require("global")

local servers = {
  cssls = {},
  eslint = {},
  html = {},
  jsonls = {},
  ansiblels = global.is_unix and {} or nil,
  graphql = {},
  hls = global.is_unix and { filetypes = { "haskell", "lhaskell", "cabal" } } or nil,
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
      },
    },
  },
  emmylua_ls = {},
  tailwindcss = {},
  prismals = {},
  terraformls = {},
  vtsls = {
    settings = {
      vtsls = {
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
            entriesLimit = 1000,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = "always",
        tsserver = {
          maxTsServerMemory = 8192,
        },
      },
    },
  },
  bashls = {},
  gopls = {},
  kulala_ls = {},
  golangci_lint_ls = {},
}

return servers
