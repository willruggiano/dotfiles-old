-- I like this structure:
-- workspace/
--   build/
--     Debug/
--     Release/
--   ...
vim.g.cmake_default_config = "Debug"
vim.g.cmake_build_dir_location = "build"

-- TODO: Change this to try to detect whether the existing options already contain the
-- export-compile-commands option.
local cmake_generate_options = vim.g.cmake_generate_options
table.insert(cmake_generate_options, "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
vim.g.cmake_generate_options = cmake_generate_options

vim.g.cmake_jump_on_error = 0 -- Don't jump to the CMake window on build failure
-- TODO: Even better would be to open a Telescope prompt based on the quickfix list with preview
-- windows showing the error message (and context, e.g. the warnings, "included from ..."s, etc) and
-- another preview window showing the file.
vim.cmd [[
  augroup MyCmakeGroup
    au  User CMakeBuildFailed    CMakeClose
    au  User CMakeBuildFailed    TroubleToggle quickfix
    au! User CMakeBuildSucceeded CMakeClose
  augroup END
]]

vim.cmd [[cnoreabbrev cmake CMakeGenerate]]
vim.cmd [[cnoreabbrev build CMakeBuild]]
