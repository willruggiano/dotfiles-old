local wk = require "which-key"

wk.register({
  ["<leader>d"] = {
    s = {
      name = "start",
      ["<tab>"] = { require("telescope").extensions.vimspector.configurations, "select" },
      ["<cr>"] = { "<Plug>VimspectorContinue", "default" },
    },
  },
}, {
  buffer = 0,
})
