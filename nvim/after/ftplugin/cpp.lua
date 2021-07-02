vim.bo.commentstring = '// %s'

local keymap = require('astronauta.keymap')

keymap.nnoremap { 'K', '<cmd>CppMan<cr>', buffer = true }

