local wk = require("which-key")

wk.register({
  ["<leader>t"] = {
    name = "toggle",
    o = { require("symbols-outline").toggle_outline, "outline" }
  }
})

