local nnoremap = vim.keymap.nnoremap
local xnoremap = vim.keymap.xnoremap

nnoremap { '<leader>di', '<Plug>VimspectorBalloonEval' }
xnoremap { '<leader>di', '<Plug>VimspectorBalloonEval' }
nnoremap { '<localleader><f11>', '<Plug>VimspectorUpFrame' }
nnoremap { '<localleader><f12>', '<Plug>VimspectorDownFrame' }
