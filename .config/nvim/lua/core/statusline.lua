local api = vim.api
local opt = vim.opt
local fn = vim.fn
local set_hl = function(group, options)
  local bg = options.bg == nil and "" or "guibg=" .. options.bg
  local fg = options.fg == nil and "" or "guifg=" .. options.fg
  local gui = options.gui == nil and "" or "gui=" .. options.gui

  vim.cmd(string.format("hi %s %s %s %s", group, bg, fg, gui))
end

local highlights = {
  { "Mode", { bg = "#8CAAEE", fg = "#1D2021", gui = "bold" } },
  { "LineCol", { bg = "#8CAAEE", fg = "#1D2021", gui = "bold" } },
  { "Git", { bg = "#292C3C", fg = "#8CAAEE" } },
  { "Filetype", { bg = "#292C3C", fg = "#c6d0f5" } },
  { "Filename", { bg = "#292C3C", fg = "#EBDBB2" } },
}

for _, highlight in ipairs(highlights) do
  set_hl(highlight[1], highlight[2])
end

local M = {}

M.modes = setmetatable({
  ["n"] = { "Normal", "N" },
  ["no"] = { "N·Pending", "N·P" },
  ["v"] = { "Visual", "V" },
  ["V"] = { "V·Line", "V·L" },
  [""] = { "V·Block", "V·B" },
  ["s"] = { "Select", "S" },
  ["S"] = { "S·Line", "S·L" },
  [""] = { "S·Block", "S·B" },
  ["i"] = { "Insert", "I" },
  ["ic"] = { "Insert", "I" },
  ["R"] = { "Replace", "R" },
  ["Rv"] = { "V·Replace", "V·R" },
  ["c"] = { "Command", "C" },
  ["cv"] = { "Vim·Ex ", "V·E" },
  ["ce"] = { "Ex ", "E" },
  ["r"] = { "Prompt ", "P" },
  ["rm"] = { "More ", "M" },
  ["r?"] = { "Confirm ", "C" },
  ["!"] = { "Shell ", "S" },
  ["t"] = { "Terminal ", "T" },
}, {
  __index = function()
    return { "Unknown", "U" }
  end,
})

M.trunc_width = setmetatable({
  mode = 80,
  git_status = 90,
  filename = 140,
  line_col = 60,
}, {
  __index = function()
    return 80
  end,
})

M.is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode

  if self:is_truncated(self.trunc_width.mode) then
    return string.format(" %s ", self.modes[current_mode][2]):upper()
  end

  return string.format(" %s ", self.modes[current_mode][1]):upper()
end

M.get_git_status = function(self)
  local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
  local is_head_empty = signs.head ~= ""

  if self:is_truncated(self.trunc_width.git_status) then
    return is_head_empty and string.format("  %s ", signs.head or "") or ""
  end

  return is_head_empty
      and string.format(" +%s ~%s -%s |  %s ", signs.added, signs.changed, signs.removed, signs.head)
    or ""
end

M.get_filename = function(self)
  if self:is_truncated(self.trunc_width.filename) then
    return " %<%f "
  end
  return " %<%F "
end

M.get_filetype = function()
  local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
  local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })
  local filetype = vim.bo.filetype

  if filetype == "" then
    return ""
  end
  return string.format(" %s %s ", icon, filetype):lower()
end

M.get_line_col = function(self)
  if self:is_truncated(self.trunc_width.line_col) then
    return " %l:%c "
  end
  return "  %l:%c "
end

M.get_lsp_diagnostic = function(self)
  local result = {}
  local levels = {
    errors = vim.diagnostic.severity.ERROR,
    warnings = vim.diagnostic.severity.WARN,
    hints = vim.diagnostic.severity.HINT,
  }

  for k, level in pairs(levels) do
    result[k] = #(vim.diagnostic.get(0, { severity = level }))
  end

  if self:is_truncated(self.trunc_width.diagnostic) then
    return ""
  else
    return string.format(" :%s :%s :%s ", result["errors"] or 0, result["warnings"] or 0, result["hints"] or 0)
  end
end

M.colors = {
  active = "%#StatusLine#",
  inactive = "%#StatusLineNC#",
  mode = "%#Mode#",
  git = "%#Git#",
  filetype = "%#Filetype#",
  line_col = "%#LineCol#",
}

M.init = function(self)
  local colors = self.colors

  local mode = colors.mode .. self:get_current_mode()
  local git = colors.active .. self:get_git_status()
  local lsp_diagnostic = colors.active .. self:get_lsp_diagnostic()
  local filename = colors.inactive .. self:get_filename()
  local filetype = colors.active .. self:get_filetype()
  local line_col = colors.line_col .. self:get_line_col()

  return table.concat({
    colors.active,
    mode,
    lsp_diagnostic,
    git,
    "%=",
    filename,
    "%=",
    filetype,
    line_col,
  })
end

Statusline = setmetatable(M, {
  __call = function(statusline)
    return statusline:init()
  end,
})

opt.laststatus = 3
opt.statusline = "%!v:lua.Statusline()"

return M
