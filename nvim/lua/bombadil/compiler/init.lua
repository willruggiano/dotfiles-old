local Terminal = require("toggleterm.terminal").Terminal

local compiler = {}

local cwd = vim.fn.getcwd()

vim.g.bombadil = vim.tbl_deep_extend("keep", vim.g.bombadil, {
  compiler = {
    opts = {
      source_dir = cwd,
      binary_dir = cwd .. "/build/Debug",
      build_type = "Debug",
      build_target = "test_cgx_xpa",
      build_parallelism = "16",
      generator = "Ninja",
    },
    state = "loaded",
  },
})

compiler.opts = function()
  return vim.g.bombadil.compiler.opts
end

compiler.generate = function()
  local opts = compiler.opts()
  local exe = "cmake"
  local args = {
    "-S " .. opts.source_dir,
    "-B " .. opts.binary_dir,
    "-G " .. opts.generator,
    "-DBUILD_ALL=ON",
    "-DCMAKE_BUILD_TYPE=" .. opts.build_type,
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
  }

  local term = Terminal:new {
    dir = opts.source_dir,
    hidden = true,
  }
  compiler.term = term
  vim.g.bombadil.compiler.state = "available"

  if not term:is_open() then
    term:open()
  end
  term:send(exe .. " " .. table.concat(args, " "))

  return term
end

compiler.set_build_target = function(build_target)
  compiler.opts().build_target = build_target
end

compiler.set_build_type = function(build_type)
  local previous_build_type = compiler.opts().build_type
  compiler.opts().build_type = build_type
  if previous_build_type ~= build_type then
    compiler.generate()
  end
end

compiler.compile = function(target)
  local opts = compiler.opts()
  local cmd = {
    exe = "cmake",
    args = {
      "--build " .. opts.binary_dir,
      "--target " .. (target or opts.build_target),
      "--parallel " .. opts.build_parallelism,
    },
  }

  local term = compiler.term

  if term == nil then
    term = compiler.generate()
  end

  if not term:is_open() then
    term:open()
  end
  term:send(cmd.exe .. " " .. table.concat(cmd.args, " "))
end

compiler.info = function()
  print(vim.inspect(vim.g.bombadil.compiler))
end

compiler.toggle = function()
  local term = compiler.opts().term
  term:toggle()
end

vim.cmd [[command! MakeGenerate lua R("bombadil.compiler").generate()]]
vim.cmd [[command! MakeToggle lua require("bombadil.compiler").toggle()]]
vim.cmd [[command! MakeInfo lua require("bombadil.compiler").info()]]
vim.cmd [[command! -bang -nargs=? MakeTarget lua require("bombadil.compiler").compile(<f-args>)]]
vim.cmd [[command! -bang Make lua require("bombadil.compiler").compile()]]

return compiler
