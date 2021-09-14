local icons = require "nvim-nonicons"

vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    severity_limit = "Error",
    spacing = 4,
    prefix = icons.get "dot-fill",
  },
})

local signs = {
  Error = icons.get "circle-slash",
  Warning = icons.get "alert",
  Hint = icons.get "light-bulb",
  Information = icons.get "info",
}

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local preview_location = function(location, method)
  local context = 15
  -- We need to change the range reported by the LSP (at least for clangd) since it only gives us
  -- the first line of the definition
  if location.targetRange ~= nil then
    local range = location.targetRange
    -- TODO(2021-09-14,wruggian): Use treesitter to get the whole thing?
    range["end"].line = range["end"].line + context
    location.targetRange = range
  else
    local range = location.range
    -- TODO(2021-09-14,wruggian): Use treesitter to get the whole thing?
    range["end"].line = range["end"].line + context
    location.range = range
  end
  return vim.lsp.util.preview_location(location, { border = "single" })
end

local M = {}

M.peek_definition = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, ctx)
    if vim.tbl_islist(result) then
      preview_location(result[1], ctx.method)
    else
      preview_location(result, ctx.method)
    end
  end)
end

return M
