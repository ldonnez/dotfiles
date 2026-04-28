local M = {}

---@class pack.keymap
---@field [1] (string|string[]) Mode
---@field [2] string LHS
---@field [3] string|function RHS
---@field [4]? vim.api.keyset.keymap

---@class pack.load_opts
---@field events? vim.api.keyset.events[]
---@field filetypes? string[]
---@field commands? string[]
---@field keymaps? pack.keymap[]

---@param specs (string|vim.pack.Spec)[]
---@param setup? function
local function load(specs, setup)
  vim.pack.add(specs)
  if setup then
    setup()
  end
end

---@param events vim.api.keyset.events[]
---@param fn function
local function on_events(events, fn)
  vim.api.nvim_create_autocmd(events, { once = true, callback = fn })
end

---@param filetypes string[]
---@param fn function
local function on_filetypes(filetypes, fn)
  vim.api.nvim_create_autocmd("FileType", { pattern = filetypes, once = true, callback = fn })
end

---@param commands string[]
---@param fn function
local function on_commands(commands, fn)
  for _, cmd in ipairs(commands) do
    vim.api.nvim_create_user_command(cmd, function(args)
      for _, c in ipairs(commands) do
        pcall(vim.api.nvim_del_user_command, c)
      end
      fn()
      vim.cmd({ cmd = cmd, args = args.fargs, bang = args.bang })
    end, { nargs = "*", bang = true })
  end
end

---@param keymaps pack.keymap[]
---@param load_fn function
local function on_keymaps(keymaps, load_fn)
  for _, km in ipairs(keymaps) do
    local mode = km[1] or "n"
    local lhs = km[2]
    local rhs = km[3]
    local opts = km[4] or {}

    vim.keymap.set(mode, lhs, function()
      load_fn()
      if type(rhs) == "function" then
        rhs()
      else
        vim.cmd(rhs)
      end
    end, opts)
  end
end

---Load a plugin with optional lazy loading.
---If opts is a function, loads immediately with that function as setup.
---If opts is a table with events/filetypes/commands/keymaps, uses lazy loading.
---Otherwise, loads immediately.
---@param specs (string|vim.pack.Spec)[] Plugin specifications (same as vim.pack.add)
---@param opts? pack.load_opts|function Options: events, filetypes, commands, keymaps; or setup function for immediate load
---@param setup? function Setup function to run after plugin is loaded
function M.load(specs, opts, setup)
  local done = false

  local function lazy()
    if done then
      return
    end
    done = true
    local s = type(opts) == "function" and opts or setup
    load(specs, s)
  end

  local lazy_opts = nil
  if type(opts) == "table" then
    lazy_opts = opts
  end

  if lazy_opts and (lazy_opts.events or lazy_opts.filetypes or lazy_opts.commands or lazy_opts.keymaps) then
    if lazy_opts.events then
      on_events(lazy_opts.events, lazy)
    end
    if lazy_opts.filetypes then
      on_filetypes(lazy_opts.filetypes, lazy)
    end
    if lazy_opts.commands then
      on_commands(lazy_opts.commands, lazy)
    end
    if lazy_opts.keymaps then
      on_keymaps(lazy_opts.keymaps, lazy)
    end
  else
    lazy()
  end
end

return M
