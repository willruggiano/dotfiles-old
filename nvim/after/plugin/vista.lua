vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_echo_cursor_strategy = 'floating_win'

local keymap = require('astronauta.keymap')

keymap.nnoremap { '<space>vd', '<cmd>Vista finder fzf:nvim_lsp<cr>' }
keymap.nnoremap { '<space>vv', '<cmd>Vista!!<cr>' }

