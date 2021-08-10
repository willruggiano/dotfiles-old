local icons = require "nvim-nonicons"

require("nvim-web-devicons").setup {
  lir_folder_icon = {
    icons = icons.get "file",
    color = "#7ebae4",
    name = "LirFolderNode",
  },
}

local actions = require "lir.actions"
local lir = require "lir"
local lir_utils = require "lir.utils"
local lvim = require "lir.vim"
local Path = require "plenary.path"

local get_context = lvim.get_context

local custom_actions = {}

custom_actions.up = function()
  local up = actions.up
  -- TODO: Handle initial ups, e.g. from dashboard or the initial buffer
  up()
end

custom_actions.new = function()
  local ctx = get_context()

  local name = vim.fn.input(ctx.dir)
  if name == "" then
    return
  end

  local path = Path:new(ctx.dir .. name)
  if path:exists() then
    lir_utils.error "Pathname already exists"
    -- cursor jump
    local ln = ctx:indexof(name)
    if ln then
      vim.cmd(tostring(ln))
    end
    return
  end

  local pathsep = "/" -- TODO: Could be more portable here.
  if name:sub(-#pathsep) == pathsep then
    path:mkdir()
  else
    -- TODO: Doesn't seem like parent creation works.
    path:touch()
  end
  actions.reload()

  vim.schedule(function()
    local ln = lvim.get_context():indexof(name)
    if ln then
      vim.cmd(tostring(ln))
    end
  end)
end

custom_actions.stat = function()
  print "not yet!"
end

lir.setup {
  show_hidden_files = true,
  devicons_enable = true,

  float = { winblend = 15 },

  mappings = {
    ["<cr>"] = actions.edit,
    ["<tab>"] = custom_actions.select,
    v = custom_actions.vsplit,
    s = custom_actions.split,

    ["-"] = custom_actions.up,
    a = custom_actions.new,
    r = actions.rename,
    y = actions.yank_path,
    d = actions.delete,

    ["."] = actions.toggle_show_hidden,
    K = custom_actions.stat,
  },
}

require("lir.git_status").setup {
  show_ignored = false,
}

vim.keymap.nnoremap { "-", ":e %:h<cr>" }
