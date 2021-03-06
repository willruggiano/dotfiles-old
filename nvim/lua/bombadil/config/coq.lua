vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    buffers = {
      enabled = true,
    },
    lsp = {
      enabled = true,
    },
    snippets = {
      enabled = true,
      user_path = "~/.config/nvim/coq-user-snippets",
    },
    tmux = {
      enabled = false,
    },
    tree_sitter = {
      enabled = false,
    },
  },
  display = {
    preview = {
      border = {
        { "", "NormalFloat" },
        { "", "NormalFloat" },
        { "", "NormalFloat" },
        { "", "NormalFloat" },
        { "", "NormalFloat" },
        { "", "NormalFloat" },
        { "", "NormalFloat" },
        { "", "NormalFloat" },
      },
      positions = {
        north = 1,
        east = 2,
        west = 3,
        south = 4,
      },
    },
  },
  keymap = {
    jump_to_mark = "",
  },
}
