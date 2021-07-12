return function()
  vim.g.nvim_tree_side = 'left'
  vim.g.nvim_tree_width = 50
  vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
  vim.g.nvim_tree_auto_open = 0
  vim.g.nvim_tree_auto_close = 1
  vim.g.nvim_tree_quit_on_open = 0
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_hide_dotfiles = 0
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_root_folder_modifier = ':~'
  vim.g.nvim_tree_allow_resize = 1
  
  vim.g.nvim_tree_show_icons = {
      git = 1,
      folders = 1,
      files = 1
  }
  
  vim.g.nvim_tree_icons = {
      default = '',
      symlink = '',
      git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
      },
      folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
      },
      lsp = {
          hint = "",
          info = "",
          warning = "",
          error = "",
      }
  }
end