vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_echo_cursor_strategy = 'floating_win'

local nnoremap = vim.keymap.nnoremap

nnoremap { '<space>vd', '<cmd>Vista finder fzf:nvim_lsp<cr>' }
nnoremap { '<space>vv', '<cmd>Vista!!<cr>' }

