local M = {}

local augroup = vim.api.nvim_create_augroup("PackLazy", { clear = true })

---@class pack.keymap
---@field [1] string|string[]
---@field [2] string
---@field [3] string|function
---@field [4]? vim.keymap.set.Opts?

---@class pack.plugin
---@field [1] (string|vim.pack.Spec|(string|vim.pack.Spec)[])[]
---@field events? vim.api.keyset.events[]
---@field filetypes? string[]
---@field commands? string[]
---@field keymaps? pack.keymap[]
---@field init? function
---@field setup? function

-- Flatten nested spec lists into a single list.
---@param specs (string|vim.pack.Spec|(string|vim.pack.Spec)[])[]
---@return (string|vim.pack.Spec)[]
local function normalize(specs)
  local out = {}

  for _, spec in ipairs(specs) do
    -- nested list of specs
    if type(spec) == "table" and not spec.src and not spec[1] then
      vim.list_extend(out, normalize(spec))
    else
      table.insert(out, spec)
    end
  end

  return out
end

-- Add plugin specs to pack and run setup if provided.
---@param specs (string|vim.pack.Spec)[]
---@param setup? function
local function load(specs, setup)
  vim.pack.add(specs)

  if setup then
    setup()
  end
end

-- Load the plugin once when any of the given events fire.
---@param events vim.api.keyset.events[]
---@param fn function
local function on_events(events, fn)
  vim.api.nvim_create_autocmd(events, {
    group = augroup,
    once = true,
    callback = function()
      vim.schedule(fn)
    end,
  })
end

-- Load the plugin once on first match of any of the given filetypes.
---@param filetypes string[]
---@param fn function
local function on_filetypes(filetypes, fn)
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = filetypes,
    once = true,
    callback = fn,
  })
end

-- Create user commands that load the plugin on first invocation, then re-run the original command.
---@param commands string[]
---@param fn function
local function on_commands(commands, fn)
  for _, cmd in ipairs(commands) do
    vim.api.nvim_create_user_command(cmd, function(args)
      for _, c in ipairs(commands) do
        pcall(vim.api.nvim_del_user_command, c)
      end

      fn()

      vim.cmd({
        cmd = cmd,
        args = args.fargs,
        bang = args.bang,
      })
    end, { nargs = "*", bang = true })
  end
end

-- Set a single keymap, handling both function- and command-string RHS.
---@param km pack.keymap
local function set_keymap(km)
  local mode = km[1] or "n"
  local lhs = km[2]
  local rhs = km[3]
  local opts = km[4] or {}

  if type(rhs) == "function" then
    vim.keymap.set(mode, lhs, rhs, opts)
  else
    vim.keymap.set(mode, lhs, ":" .. rhs .. "<CR>", opts)
  end
end

-- Create lazy-loading keymaps. The first invocation loads the plugin and replaces all keymaps with their direct mappings.
---@param keymaps pack.keymap[]
---@param fn function
local function on_keymaps(keymaps, fn)
  for _, km in ipairs(keymaps) do
    local mode = km[1] or "n"
    local lhs = km[2]
    local rhs = km[3]
    local opts = km[4] or {}

    vim.keymap.set(mode, lhs, function()
      fn()

      for _, k in ipairs(keymaps) do
        set_keymap(k)
      end

      if type(rhs) == "function" then
        rhs()
      else
        vim.cmd(rhs)
      end
    end, opts)
  end
end

-- Register a plugin with lazy-loading triggers (events, filetypes, commands, keymaps).
---@param plugin pack.plugin
local function register(plugin)
  local done = false
  local specs = normalize(plugin[1])

  -- runs immediately during startup
  if plugin.init then
    plugin.init()
  end

  local function lazy()
    if done then
      return
    end

    done = true
    load(specs, plugin.setup)
  end

  if plugin.events then
    on_events(plugin.events, lazy)
  end

  if plugin.filetypes then
    on_filetypes(plugin.filetypes, lazy)
  end

  if plugin.commands then
    on_commands(plugin.commands, lazy)
  end

  if plugin.keymaps then
    on_keymaps(plugin.keymaps, lazy)
  end

  if not (plugin.events or plugin.filetypes or plugin.commands or plugin.keymaps) then
    lazy()
  end
end

-- Register multiple plugins with their lazy-loading configuration.
-- Usage:
--   pack.load({
--     { "https://github.com/user/repo" },
--     commands = { "Cmd" },
--     keymaps = { { "n", "<leader>x", "Cmd", { desc = "..." } } },
--     setup = function() require("repo").setup({}) end,
--   })
function M.load(...)
  for _, plugin in ipairs({ ... }) do
    register(plugin)
  end
end

return M
