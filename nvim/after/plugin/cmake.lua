-- I like this structure:
-- workspace/
--   build/
--     Debug/
--     Release/
--   ...

-- cdelledone/vim-cmake
vim.g.cmake_default_config = "Debug"
vim.g.cmake_build_dir_location = "build"
vim.g.cmake_link_compile_commands = 1

vim.g.cmake_jump_on_error = 0 -- Don't jump to the CMake window on build failure
-- TODO: Even better would be to open a Telescope prompt based on the quickfix list with preview
-- windows showing the error message (and context, e.g. the warnings, "included from ..."s, etc) and
-- another preview window showing the file.
vim.cmd [[
  function! OnCMakeBuildFailure()
    execute 'CMakeClose'
    execute 'copen'
  endfunction
  augroup MyCmakeGroup
    au  User CMakeBuildFailed    call OnCMakeBuildFailure()
    au! User CMakeBuildSucceeded CMakeClose
  augroup END
]]

vim.cmd [[cnoreabbrev cmake CMakeGenerate]]
vim.cmd [[cnoreabbrev build CMakeBuild]]
