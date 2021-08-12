local wk = require "which-key"

wk.register {
  ["<space><space>"] = {
    function()
      require("FTerm").toggle()
    end,
    "terminal",
  },
}
