vim.g.vimspector_enable_mappings = 'HUMAN'

local keymap = require('astronauta.keymap')

keymap.nmap { '<leader>di', '<Plug>VimspectorBalloonEval' }
keymap.xmap { '<leader>di', '<Plug>VimspectorBalloonEval' }
keymap.nmap { '<localleader><f11>', '<Plug>VimspectorUpFrame' }
keymap.nmap { '<localleader><f12>', '<Plug>VimspectorDownFrame' }
