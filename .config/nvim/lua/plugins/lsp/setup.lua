local global = require("global")

local lua_ls_root_path = global.plugin_installation_path .. "/lua-language-server"
local lua_ls_binary = lua_ls_root_path .. "/bin/lua-language-server"

local servers = {
  cssls = {},
  eslint = {},
  html = {},
  jsonls = {},
  graphql = {},
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
}

return servers
