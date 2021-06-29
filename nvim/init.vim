call plug#begin('~/.config/nvim/plugins')

Plug 'cdelledonne/vim-cmake'
Plug 'folke/which-key.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'dir': '~/.zinit/plugins/junegunn---fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'kevinoid/vim-jsonc'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kshenoy/vim-signature'
Plug 'lewis6991/gitsigns.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'mildred/vim-bufmru'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'puremourning/vimspector'
Plug 'rhysd/git-messenger.vim'
Plug 'rizzatti/dash.vim'
Plug 'RRethy/vim-illuminate'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
Plug 'windwp/nvim-autopairs'
Plug 'zinit-zsh/zinit-vim-syntax'

" LSP setup
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'gfanto/fzf-lsp.nvim'

" Themes, and statusline
Plug 'hoob3rt/lualine.nvim'
Plug 'ful1e5/onedark.nvim'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set termguicolors
set completeopt=menuone,noselect
filetype plugin on


"-- onedark
lua require('onedark').setup()
"--/ onedark


"-- lualine
lua <<EOF
require('lualine').setup {
  options = {
    theme = 'onedark',
    disabled_filetypes = { 'NvimTree' }
  }
}
EOF
"--/ lualine

lua require('colorizer').setup()
lua <<EOF
require('gitsigns').setup {
    current_line_blame = true
}
EOF

"-- treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
    autopairs = { enable = true },
    ensure_installed = { 'c', 'cpp', 'dockerfile', 'go', 'java', 'json', 'lua', 'python', 'rust', 'typescript', 'yaml' },
    highlight = {
        enable = true  -- false will disable the whole extension
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.inner",
                ["]M"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["}m"] = "@function.inner",
                ["}M"] = "@function.outer",
                ["}}"] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.inner",
                ["[M"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["{m"] = "@function.inner",
                ["{M"] = "@function.outer",
                ["{{"] = "@class.outer",
            },
        },
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    }
}
EOF
set foldlevelstart=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
"-- /treesitter


"-- nvim-autopairs
lua <<EOF
local npairs = require('nvim-autopairs')
npairs.setup {
    check_ts = true,
    disable_filetype = { 'vim' }
}
-- local endwise = require('nvim-autopairs.ts-rule').endwise
-- npairs.add_rules({
--     endwise('{', '};', 'cpp', 'field_declaration_list')
-- })
EOF
"-- /nvim-autopairs


"-- indentline-blankline
let g:indent_blankline_filetype_exclude = ['dashboard', 'help', 'man', 'tsplaygroud', 'vimcmake']
"--/ indentline-blankline

" \d to perform a Dash lookup
nnoremap <leader>d :Dash<cr>


"-- "toggle" keybinds
nnoremap <leader>tt :NvimTreeToggle<CR>
"--/ "toggle" keybinds


" 2021-05-13 Trying out vimspector
let g:vimspector_enable_mappings = 'HUMAN'


" Some sane defaults for navigating multiple windows
set splitright
set splitbelow
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Buffer navigation
set hidden
imap <A-B> <C-O>:BufMRUPrev<CR>
imap <A-b> <C-O>:BufMRUNext<CR>
map <A-B> :BufMRUPrev<CR>
map <A-b> :BufMRUNext<CR>
map <Tab> :BufMRUNext<CR>
map <S-Tab> :BufMRUPrev<CR>


"-- nvim-lsp

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

nvim_lsp.clangd.setup {
    cmd = { 'clangd', '--log=verbose', '--background-index' },
    on_attach = on_attach
}

nvim_lsp.pyright.setup {
    on_attach = on_attach
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'clangd', 'pyright' }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup { on_attach = on_attach }
-- end

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Compe setup
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

vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.completion_confirm()', {expr = true , noremap = true})
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', {expr = true, noremap = true})

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
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  else
    return t '<S-Tab>'
  end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
EOF

lua require('fzf_lsp').setup()

let g:vista_default_executive = 'nvim_lsp'

"--/ nvim-lsp


"-- vimspector
lua <<EOF
vim.api.nvim_set_keymap('n', '<Leader>di', '<Plug>VimspectorBalloonEval', {})
vim.api.nvim_set_keymap('x', '<Leader>di', '<Plug>VimspectorBalloonEval', {})
vim.api.nvim_set_keymap('n', '<LocalLeader><F11>', '<Plug>VimspectorUpFrame', {})
vim.api.nvim_set_keymap('n', '<LocalLeader><F12>', '<Plug>VimspectorDownFrame', {})
EOF
"-- vimspector

"-- cppman
function! s:CppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction
command! CppMan :call s:CppMan()
"--/ cppman


"-- fzf and ripgrep
nnoremap <silent><leader>ff :Files<CR>
nnoremap <silent><leader>fg :<C-u>CocCommand fzf-preview.GitFiles<CR>
nnoremap <silent><leader>fd :Files<space>
nnoremap <silent><leader>fu :Rg <C-R><C-W><CR>
nnoremap <silent><leader>fw :Rg<CR>
nnoremap <silent><leader>o :History<CR>

if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

cnoreabbrev rg Rg
"-- /fzf and ripgrep


" Specify the fuzzy finder that Dashboard uses
let g:dashboard_default_executive = 'fzf'


" Nvim-tree
let g:nvim_tree_side = 'left'
let g:nvim_tree_width = 50
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_open = 0
let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 0
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_hide_dotfiles = 0
let g:nvim_tree_git_hl = 1
let g:nvim_tree_root_folder_modifier = ':~'
let g:nvim_tree_allow_resize = 1

let g:nvim_tree_show_icons = {
            \ 'git': 1,
            \ 'folders': 1,
            \ 'files': 1
            \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
        \ 'unstaged': "✗",
        \ 'staged': "✓",
        \ 'unmerged': "",
        \ 'renamed': "➜",
        \ 'untracked': "★",
        \ 'deleted': "",
        \ 'ignored': "◌"
    \ },
    \ 'folder': {
        \ 'default': "",
        \ 'open': "",
        \ 'empty': "",
        \ 'empty_open': "",
        \ 'symlink': "",
        \ 'symlink_open': "",
    \ },
    \ 'lsp': {
        \ 'hint': "",
        \ 'info': "",
        \ 'warning': "",
        \ 'error': "",
    \ }
\ }

"-- lightspeed
lua <<EOF
require'lightspeed'.setup{}
EOF


"-- hlslens
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>
"--/ hlslens


"-- vim-registers
" let g:registers_return_symbol = "\n"
" let g:registers_tab_symbol = "\t"
" let g:registers_space_symbol = "."
"--/ vim-registers


"-- vim-terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
"--/ vim-terraform


lua <<EOF
-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})
EOF


" By default timeoutlen is 1000 ms
set timeoutlen=500

" Some sane aesthetic defaults
set encoding=utf8
set wrap
set linebreak
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set number
set fillchars=vert:\ ,fold:-,eob:~
set guifont=JetBrainsMono-Regular:h11
set cmdheight=2
set number         " Show current line number
set relativenumber " Show relative line numbers
set ignorecase
set smartcase
set signcolumn=yes


"-- theme
let g:moonlight_borders = 0
let g:moonlight_contrast = 0
syntax enable
filetype plugin indent on
colorscheme onedark
"-- /theme


" Abbreviations
cnoreabbrev cmake CMakeGenerate
cnoreabbrev build CMakeBuild
cnoreabbrev git Git
cnoreabbrev h vert help
cnoreabbrev md MarkdownPreview


" Allow loading local, project-specific .nvimrc files
set exrc
" ... but disallow autocommands
set secure

