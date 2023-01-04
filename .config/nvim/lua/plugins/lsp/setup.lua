local global = require("config.global")

local sumneko_root_path = global.plugin_installation_path .. "/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local servers = {
  cssls = {},
  eslint = {},
  html = {},
  jsonls = {},
  yamlls = {},
  sumneko_lua = {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
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
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

return servers
