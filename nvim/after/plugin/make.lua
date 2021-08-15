vim.cmd [[command! MakeGenerate lua require("make").generate()]]
vim.cmd [[command! MakeToggle lua require("make").toggle()]]
vim.cmd [[command! MakeInfo lua require("make").info()]]
vim.cmd [[command! -bang -nargs=? MakeTarget lua require("make").compile(<f-args>)]]
vim.cmd [[command! -bang Make lua require("make").compile()]]
vim.cmd [[command! -nargs=1 SetBuildType lua require("make").set_build_type(<f-args>)]]
vim.cmd [[command! -nargs=1 SetBuildTarget lua require("make").set_build_target(<f-args>)]]
