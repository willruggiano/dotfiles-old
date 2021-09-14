local utils = require "refactoring.code_generation.utils"

-- TODO: [2021-09-14,wruggian]: These need a lot of work. Namely, we need type information
-- (return type, variable type, etc) since we are, in fact, working in C++ instead of a
-- dynamic language!
local cpp = {
  constant = function(opts)
    -- TODO: [2021-09-14,wruggian]: Need a variable type!
    -- But that is generally speaking going to be a tough thing to deterive using just
    -- treesitter. We will almost certainly need help from the lsp server.
    assert(opts.type, "C++ requires type information")
    return string.format("const %s %s = %s;\n", opts.type, opts.name, opts.value)
  end,

  ["return"] = function(code)
    return string.format("return %s;", utils.stringify_code(code))
  end,

  -- TODO: [2021-09-14,wruggian]: This is an even trickier one!
  -- We have TWO types of functions to deal with:
  --   1. Global functions
  --   2. Member functions
  -- So we will likely need to either (1) add a whole new pathway for each, or (2) encode
  -- this information in the opts.
  -- I think we could derive this information from the syntax tree? And then we can make a
  -- decision about what type of function to generate by inferring whether *this was used?
  -- Hmm... tricky, because, like lambdas, we sometimes implicitly need `this` when
  -- referencing member variables.
  ["function"] = function(opts)
    assert(false, "not implemented")
    return string.format(
      [[
function %s(%s) {
    %s
}
      ]],
      opts.name,
      table.concat(opts.args, ", "),
      utils.stringify_code(opts.body)
    )
  end,

  -- TODO: [2021-09-14,wruggian]: There are even intricacies here!
  -- For example, sometimes it will be necessary to do scope resolution before calling a
  -- member function (e.g. `this->foo()`)
  call_function = function(opts)
    return string.format("%s(%s);", opts.name, table.concat(opts.args, ", "))
  end,
}

return cpp
