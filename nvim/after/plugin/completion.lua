vim.opt.completeopt = { 'menuone', 'noselect' }

-- Don't show the dumb matching stuff
vim.opt.shortmess:append 'c'

require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

-- Setup completion confirmation to take into account autopairs
local npairs = require('nvim-autopairs')
_G.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn['compe#confirm'](npairs.esc('<CR>'))
    else
      return npairs.esc('<CR>')
    end
  else
    return npairs.autopairs_cr()
  end
end

local keymap = require('astronauta.keymap')

keymap.inoremap{ '<cr>', 'v:lua.completion_confirm()', expr = true }
keymap.inoremap{ '<c-space>', 'compe#complete()', expr = true }
keymap.inoremap{ '<c-e>', 'compe#close("<c-e>")', expr = true }

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<c-n>'
  elseif check_back_space() then
    return t '<tab>'
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<c-p>'
  else
    return t '<s-tab>'
  end
end

keymap.inoremap{ '<tab>', 'v:lua.tab_complete()', expr = true }
keymap.snoremap{ '<tab>', 'v:lua.tab_complete()', expr = true }
keymap.inoremap{ '<s-tab>', 'v:lua.s_tab_complete()', expr = true }
keymap.snoremap{ '<s-tab>', 'v:lua.s_tab_complete()', expr = true }

