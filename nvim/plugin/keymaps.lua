local wk = require "which-key"
local inoremap = vim.keymap.inoremap
local nnoremap = vim.keymap.nnoremap
local tnoremap = vim.keymap.tnoremap

-- WhichKey doesn't seem to like these
-- Opens line above or below the current line
-- TODO(2021-09-13,wruggian): These don't seem to take for some reason...
inoremap { "<c-cr>", "<c-o>O" }
inoremap { "<s-cr>", "<c-o>o" }
-- Better pane navigation
nnoremap { "<c-j>", "<c-w><c-j>" }
nnoremap { "<c-k>", "<c-w><c-k>" }
nnoremap { "<c-h>", "<c-w><c-h>" }
nnoremap { "<c-l>", "<c-w><c-l>" }
-- Scrolling
nnoremap { "<up>", "<c-y>" }
nnoremap { "<down>", "<c-e>" }
-- Tab navigation
nnoremap { "<right>", "gt" }
nnoremap { "<lef>", "gT" }
-- Make ESC leave terminal mode
tnoremap { "<esc>", "<c-\\><c-n>" }

wk.register {
  -- Silent save
  ["<c-s>"] = { "<cmd>silent update<cr>", "save" },

  -- Does anyone even use macros?
  q = {
    function()
      require("bufdelete").bufdelete(0, true)
    end,
    "close",
  },
  Q = { "<cmd>quitall<cr>", ":quitall" },
}
