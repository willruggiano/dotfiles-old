if not pcall(require, 'colorbuddy') then
    return
end

vim.opt.termguicolors = true

vim.g.material_style = 'palenight'

require('material').set()
require('colorbuddy').colorscheme = 'material'
require('colorizer').setup()

vim.keymap.nnoremap { '<leader>mm', require('material.functions').toggle_style }

