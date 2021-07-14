-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/bombadil/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/bombadil/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/bombadil/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/bombadil/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/bombadil/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim"
  },
  ["dash.vim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/dash.vim"
  },
  ["dashboard-nvim"] = {
    config = { "\27LJ\2\nG\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\14telescope dashboard_default_executive\6g\bvim\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["express_line.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/express_line.nvim"
  },
  ["formatter.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\a\0\r6\0\0\0'\2\1\0B\0\2\0027\0\2\0006\0\0\0'\2\3\0B\0\2\0029\0\4\0005\2\5\0006\3\2\0=\3\6\2B\0\2\1K\0\1\0\rfiletype\1\0\1\flogging\1\nsetup\14formatter\15formatters\23bombadil.formatter\frequire\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nl\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\6\0\0\14dashboard\thelp\bman\rNvimTree\rvimcmake&indent_blankline_filetype_exclude\6g\bvim\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/lightspeed.nvim"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  neogit = {
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-hlslens"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-hlslens"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-nonicons"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-nonicons"
  },
  ["nvim-terminal.lua"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rterminal\frequire\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-terminal.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n�\6\0\0\3\0\27\0?6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\0012\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0)\1\0\0=\1\a\0006\0\0\0009\0\1\0)\1\1\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\t\0006\0\0\0009\0\1\0)\1\1\0=\1\n\0006\0\0\0009\0\1\0)\1\1\0=\1\v\0006\0\0\0009\0\1\0)\1\0\0=\1\f\0006\0\0\0009\0\1\0)\1\1\0=\1\r\0006\0\0\0009\0\1\0'\1\15\0=\1\14\0006\0\0\0009\0\1\0)\1\1\0=\1\16\0006\0\0\0009\0\1\0005\1\18\0=\1\17\0006\0\0\0009\0\1\0005\1\20\0005\2\21\0=\2\22\0015\2\23\0=\2\24\0015\2\25\0=\2\26\1=\1\19\0K\0\1\0\blsp\1\0\4\nerror\b\thint\b\tinfo\b\fwarning\b\vfolder\1\0\6\fdefault\b\15empty_open\b\fsymlink\b\17symlink_open\b\nempty\b\topen\b\bgit\1\0\a\frenamed\b➜\runstaged\b✗\vstaged\b✓\fdeleted\b\runmerged\b\fignored\b◌\14untracked\b★\1\0\2\fsymlink\b\fdefault\b\20nvim_tree_icons\1\0\3\ffolders\3\1\bgit\3\1\nfiles\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\a:~#nvim_tree_root_folder_modifier\21nvim_tree_git_hl\28nvim_tree_hide_dotfiles\29nvim_tree_indent_markers\21nvim_tree_follow\27nvim_tree_quit_on_open\25nvim_tree_auto_close\24nvim_tree_auto_open\1\4\0\0\t.git\17node_modules\v.cache\21nvim_tree_ignore\20nvim_tree_width\tleft\19nvim_tree_side\6g\bvim\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["telescope-cheat.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-cheat.nvim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-github.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\17auto_preview\1\14auto_fold\2\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["twilight.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/twilight.nvim"
  },
  ["vim-bufmru"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-bufmru"
  },
  ["vim-cmake"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-cmake"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-jsonc"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-jsonc"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-signature"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-signature"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-terraform"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-terraform"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  vimspector = {
    loaded = true,
    needs_bufread = false,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/opt/vimspector"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  },
  ["zinit-vim-syntax"] = {
    loaded = true,
    path = "/home/bombadil/.local/share/nvim/site/pack/packer/start/zinit-vim-syntax"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: vimspector
time([[Setup for vimspector]], true)
try_loadstring("\27LJ\2\nB\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\nHUMAN\31vimspector_enable_mappings\6g\bvim\0", "setup", "vimspector")
time([[Setup for vimspector]], false)
time([[packadd for vimspector]], true)
vim.cmd [[packadd vimspector]]
time([[packadd for vimspector]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nl\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\6\0\0\14dashboard\thelp\bman\rNvimTree\rvimcmake&indent_blankline_filetype_exclude\6g\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\a\0\r6\0\0\0'\2\1\0B\0\2\0027\0\2\0006\0\0\0'\2\3\0B\0\2\0029\0\4\0005\2\5\0006\3\2\0=\3\6\2B\0\2\1K\0\1\0\rfiletype\1\0\1\flogging\1\nsetup\14formatter\15formatters\23bombadil.formatter\frequire\0", "config", "formatter.nvim")
time([[Config for formatter.nvim]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
try_loadstring("\27LJ\2\nG\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\14telescope dashboard_default_executive\6g\bvim\0", "config", "dashboard-nvim")
time([[Config for dashboard-nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n�\6\0\0\3\0\27\0?6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\0012\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0)\1\0\0=\1\a\0006\0\0\0009\0\1\0)\1\1\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\t\0006\0\0\0009\0\1\0)\1\1\0=\1\n\0006\0\0\0009\0\1\0)\1\1\0=\1\v\0006\0\0\0009\0\1\0)\1\0\0=\1\f\0006\0\0\0009\0\1\0)\1\1\0=\1\r\0006\0\0\0009\0\1\0'\1\15\0=\1\14\0006\0\0\0009\0\1\0)\1\1\0=\1\16\0006\0\0\0009\0\1\0005\1\18\0=\1\17\0006\0\0\0009\0\1\0005\1\20\0005\2\21\0=\2\22\0015\2\23\0=\2\24\0015\2\25\0=\2\26\1=\1\19\0K\0\1\0\blsp\1\0\4\nerror\b\thint\b\tinfo\b\fwarning\b\vfolder\1\0\6\fdefault\b\15empty_open\b\fsymlink\b\17symlink_open\b\nempty\b\topen\b\bgit\1\0\a\frenamed\b➜\runstaged\b✗\vstaged\b✓\fdeleted\b\runmerged\b\fignored\b◌\14untracked\b★\1\0\2\fsymlink\b\fdefault\b\20nvim_tree_icons\1\0\3\ffolders\3\1\bgit\3\1\nfiles\3\1\25nvim_tree_show_icons\27nvim_tree_allow_resize\a:~#nvim_tree_root_folder_modifier\21nvim_tree_git_hl\28nvim_tree_hide_dotfiles\29nvim_tree_indent_markers\21nvim_tree_follow\27nvim_tree_quit_on_open\25nvim_tree_auto_close\24nvim_tree_auto_open\1\4\0\0\t.git\17node_modules\v.cache\21nvim_tree_ignore\20nvim_tree_width\tleft\19nvim_tree_side\6g\bvim\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\17auto_preview\1\14auto_fold\2\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: nvim-terminal.lua
time([[Config for nvim-terminal.lua]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rterminal\frequire\0", "config", "nvim-terminal.lua")
time([[Config for nvim-terminal.lua]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
