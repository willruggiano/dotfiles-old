local refactor = require "refactoring"

refactor.setup {
  code_generation = {
    cpp = R "bombadil.refactor.cpp",
  },
}
