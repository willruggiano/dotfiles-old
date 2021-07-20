vim.cmd [[au BufWinEnter <buffer> ++once :silent vertical resize 80<CR>]]

local keymap = require "astronauta.keymap"

keymap.nnoremap { "q", "<cmd>helpclose<cr>", buffer = true }
