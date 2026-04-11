local user_command = vim.api.nvim_create_user_command

-- Running :PackUpdate without arguments updates all the plugins.
-- :PackUpdate <plugin-name> updates a single plugin.
user_command("PackUpdate", function(opts)
  local arg = opts.args

  if arg and arg ~= "" then
    return vim.pack.update({ arg })
  end

  return vim.pack.update()
end, {
  nargs = "?",
  desc = "Updates plugins with vim.pack",
})

-- Restores all plugins from lockfile
user_command("PackRestore", function()
  return vim.pack.update(nil, { target = "lockfile" })
end, {
  desc = "Restores all plugins from lockfile",
})

-- List all installed plugins
user_command("PackInfo", function()
  return vim.pack.update(nil, { offline = true })
end, {
  desc = "Explore installed plugins",
})

-- :PackDel <plugin-name> deletes a single plugin.
user_command("PackDel", function(opts)
  local arg = opts.args

  if arg and arg ~= "" then
    return vim.pack.del({ arg })
  end
end, {
  nargs = "?",
  desc = "Deletes plugin with vim.pack",
})

-- Shows info about active LSP's.
user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, {
  desc = "Shows info about active LSP's",
})
