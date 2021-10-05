vim.opt.completeopt = { "menuone", "noselect" }

-- Don't show the dumb matching stuff
vim.opt.shortmess:append "c"
vim.opt.pumheight = 20

require "coq_3p" {
  {
    src = "nvimlua",
    short_name = "nLUA",
  },
  {
    src = "repl",
    sh = "zsh",
    -- shell = { p = "perl", n = "node", ... },
    max_lines = 99,
    deadline = 500,
  },
}
