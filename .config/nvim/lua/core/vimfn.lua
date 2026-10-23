---@class VimFn
---@field expand fun(expr: string): string
---@field fnamemodify fun(filename: string, mods: string): string
---@field getbufvar fun(buf: integer|string, varname: string, default?: any): any
---@field getcwd fun(winnr?: integer, tabnr?: integer): string
---@field setreg fun(regname: string, value: string): integer
---@field stdpath fun(what: string): string
---@field tabpagebuflist fun(tabnr?: integer): integer[]
---@field tabpagewinnr fun(tabnr?: integer): integer
---@field winrestview fun(view: table): integer
---@field winsaveview fun(): table
local M = vim.fn --[[@as VimFn]]

return M
