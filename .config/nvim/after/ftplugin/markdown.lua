vim.opt_local.spell = true
vim.opt_local.spelllang = "en,nl"
vim.opt_local.spelloptions = "camel"
vim.opt_local.foldlevel = 1
vim.opt_local.foldlevelstart = 1

---@alias TodoState  "todo" | "all" | "done"
---@alias TodoLines {lnum: integer, raw: string}[]

--- @param bufnr integer
--- @param state TodoState
--- @return TodoLines
local function collect_todos(bufnr, state)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local items = {}

  local allowed = {}
  if state == "all" then
    allowed = { [" "] = true, ["x"] = true, ["X"] = true }
  elseif state == "todo" then
    allowed = { [" "] = true }
  elseif state == "done" then
    allowed = { ["x"] = true, ["X"] = true }
  end

  for lnum, line in ipairs(lines) do
    local box = line:match("^%s*[-*+]%s+%[(.)%]")
    if box and allowed[box] then
      table.insert(items, { lnum = lnum, raw = line })
    end
  end

  return items
end

--- @param lines TodoLines
--- @return string[]
local function build_items(lines)
  local items = {}
  for _, line in pairs(lines) do
    table.insert(items, string.format("%d: %s", line.lnum, line.raw))
  end
  return items
end

--- @param bufnr integer
--- @param selected string[]
local function send_to_qf(bufnr, selected)
  if #selected > 0 then
    local qf_list = {}
    for _, entry in ipairs(selected) do
      local lnum_str, text = entry:match("^(%d+):%s*(.*)")
      if lnum_str then
        table.insert(qf_list, {
          bufnr = bufnr,
          lnum = tonumber(lnum_str),
          col = 1,
          text = text,
        })
      end
    end

    vim.fn.setqflist(qf_list, "r")
    vim.fn.setqflist({}, "a", { title = "Todos" })

    vim.cmd("set switchbuf=useopen,usetab")

    vim.cmd("copen")
  end
end

local function load_fzf_lua()
  local ok, mod = pcall(require, "fzf-lua")

  if not ok then
    pcall(vim.cmd.packadd, "fzf-lua")
    _, mod = pcall(require, "fzf-lua")
  end

  return mod
end

--- @param state TodoState
local function current_buffer_todo_picker(state)
  local fzf = load_fzf_lua()

  if not fzf then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local lines = collect_todos(bufnr, state)

  --- @diagnostic disable-next-line: need-check-nil
  fzf.fzf_exec(build_items(lines), {
    prompt = state:upper() .. "> ",
    keymap = {
      fzf = {
        ["ctrl-a"] = "toggle-all",
      },
    },
    fzf_opts = {
      ["--multi"] = true,
    },
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        if #selected > 1 then
          return send_to_qf(bufnr, selected)
        end

        local entry = selected[1]
        local match = entry:match("^(%d+):")

        if not match then
          return
        end

        -- Ensure integer
        local lnum = math.floor(match)

        if lnum then
          vim.api.nvim_win_set_cursor(0, { lnum, 0 })
          vim.cmd("normal! zvzz")
        end
      end,
      ["ctrl-q"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        send_to_qf(bufnr, selected)
      end,
    },
  })
end

vim.keymap.set("n", "<localleader>mtt", function()
  current_buffer_todo_picker("todo")
end, { desc = "Find TODOs in buffer" })

vim.keymap.set("n", "<localleader>mta", function()
  current_buffer_todo_picker("all")
end, { desc = "Find all TODOs in buffer" })

vim.keymap.set("n", "<localleader>mtd", function()
  current_buffer_todo_picker("done")
end, { desc = "Find done TODOs in buffer" })
