local icons = require "nvim-nonicons"

require("todo-comments").setup {
  signs = true,
  keywords = {
    FIX = {
      icon = icons.get "bug",
    },
    TODO = {
      icon = icons.get "tasklist",
    },
    HACK = {
      icon = icons.get "flame",
    },
    WARN = {
      icon = icons.get "alert",
    },
    PERF = {
      icon = icons.get "stopwatch",
    },
    NOTE = {
      icon = icons.get "comment",
    },
  },
}
