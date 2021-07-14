-- if not pcall(require, "colorbuddy") then
--   return
-- end

vim.opt.termguicolors = true

vim.g.material_style = "palenight"
vim.g.material_italic_comments = 1
vim.g.material_italic_keywords = 0
vim.g.material_italic_functions = 0
vim.g.material_lsp_underline = 1

require('material').set()
vim.keymap.nnoremap { '<leader>mm', require('material.functions').toggle_style }

vim.o.background = "dark"

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_sidebars = {
  "qf",
  "vista_kind",
  "terminal",
  "packer",
  "spectre_panel",
  "NeogitStatus",
  "help",
}
vim.g.tokyonight_cterm_colors = false
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = false
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_colors = {}

-- require("tokyonight").colorscheme()

-- require('colorbuddy').colorscheme = 'material'
require('colorizer').setup()
