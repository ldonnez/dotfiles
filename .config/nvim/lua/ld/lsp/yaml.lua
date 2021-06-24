
local function get_cmd()
  if vim.fn.has('win32') == 1 then
    return { "yaml-language-server.cmd", "--stdio" }
  else
    return { "yaml-language-server", "--stdio" }
  end
end

require'lspconfig'.yamlls.setup{
  cmd = get_cmd()
}
