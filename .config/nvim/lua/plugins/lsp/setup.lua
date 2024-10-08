local global = require("global")

local lua_ls_root_path = global.plugin_installation_path .. "/lua-language-server"
local lua_ls_binary = lua_ls_root_path .. "/bin/lua-language-server"

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
  tailwindcss = {},
  prismals = {},
  lua_ls = {
    cmd = { lua_ls_binary, "-E", lua_ls_root_path .. "/main.lua" },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
        format = {
          enable = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
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
}

return servers
