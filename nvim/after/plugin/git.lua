require "colorbuddy"

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group

Group.new("GitSignsAdd", c.green)
Group.new("GitSignsChange", c.yellow)
Group.new("GitSignsDelete", c.red)

require("gitsigns").setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr" },
    change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "GitSignsDelete", text = "~", numhl = "GitSignsChangeNr" },
  },

  -- Can't decide if I like this or not :)
  numhl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    -- ["n <space>hd"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
    -- ["n <space>hu"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

    -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    -- ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    -- ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  },
}

require("which-key").register {
  ["<space>h"] = {
    name = "git-hunk",
    n = { "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'", expr = true, "next" },
    p = { "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'", expr = true, "previous" },
  },
  ["<space>tg"] = {
    name = "git",
    m = { "<plug>(git-messenger)", "messenger" },
  },
}

local neogit = require "neogit"

require("which-key").register {
  ["<leader>g"] = {
    name = "git",
    s = { neogit.open, "status" },
    c = {
      function()
        neogit.open { "commit" }
      end,
      "commit",
    },
  },
}

local worktree = require "git-worktree"
local Job = require "plenary.job"

worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Create then
    if vim.fn.filereadable ".gitmodules" == 1 then
      Job
        :new({
          command = "git",
          args = { "submodule", "update", "--init" },
          cwd = metadata.path,
          on_start = function(...)
            print "Updating submodules..."
          end,
          on_exit = function()
            print "Done updating submodules."
          end,
        })
        :start()
    end
  end
end)
