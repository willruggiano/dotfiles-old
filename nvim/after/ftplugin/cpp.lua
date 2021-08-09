local wk = require "which-key"

wk.register({
  ["<space>r"] = {
    v = {
      name = "vimspector",
      ["<tab>"] = { require("telescope").extensions.vimspector.configurations, "configuration" },
      ["<cr>"] = { "<Plug>VimspectorContinue", "start" },
    },
  },
}, {
  buffer = 0,
})
