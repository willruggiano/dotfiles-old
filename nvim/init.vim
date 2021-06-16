call plug#begin('~/.config/nvim/plugins')

Plug 'antoinemadec/coc-fzf'
Plug 'cdelledonne/vim-cmake'
Plug 'folke/which-key.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'dir': '~/.zinit/plugins/junegunn---fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'justinmk/vim-sneak'
Plug 'kevinoid/vim-jsonc'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kshenoy/vim-signature'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'mildred/vim-bufmru'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
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
Plug 'romgrk/nvim-treesitter-context'
Plug 'RRethy/vim-illuminate'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'windwp/nvim-autopairs'
Plug 'zinit-zsh/zinit-vim-syntax'

" Always last!
Plug 'morhetz/gruvbox'
Plug 'shaunsingh/moonlight.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'tomasiser/vim-code-dark'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set termguicolors
filetype plugin on

lua require('colorizer').setup()
lua <<EOF
require('gitsigns').setup {
    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = '+',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
        },
        change = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
        delete = {
            hl = 'GitSignsDelete',
            text = '-',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = '-',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = '-',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
    },
    current_line_blame = true
}
EOF

"-- treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
    autopairs = { enable = true },
    ensure_intalled = { 'c', 'cpp', 'dockerfile', 'go', 'java', 'json', 'lua', 'python', 'rust', 'typescript', 'yaml' },
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
EOF
"-- /nvim-autopairs

" \d to perform a Dash lookup
nnoremap <leader>d :Dash<cr>


"-- "toggle" keybinds
nnoremap <leader>tt :NvimTreeToggle<CR>
"--/ "toggle" keybinds


au CmdLineEnter * set norelativenumber | redraw
au CmdlineLeave * set relativenumber


" 2021-05-13 Trying out vimspector
let g:vimspector_enable_mappings = 'HUMAN'


" Some sane defaults for navigating multiple windows
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Buffer navigation
imap <A-B> <C-O>:BufMRUPrev<CR>
imap <A-b> <C-O>:BufMRUNext<CR>
map <A-B> :BufMRUPrev<CR>
map <A-b> :BufMRUNext<CR>
map <Tab> :BufMRUNext<CR>
map <S-Tab> :BufMRUPrev<CR>


"-- coc.vim
let g:coc_global_extensions = [ 'coc-clangd', 'coc-clang-format-style-options', 'coc-cmake', 'coc-fzf-preview', 'coc-git', 'coc-json', 'coc-pyright' ]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set updatetime=100  " ms

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy :<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>
nmap <silent> gi :<C-u>CocCommand fzf-preview.CocImplementations<CR>
nmap <silent> gr :<C-u>CocCommand fzf-preview.CocReferences<CR>
nnoremap <Leader>G :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
nmap <silent> <Leader>a :CocCommand clangd.switchSourceHeader<CR>

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OrganizeImports` command for organize imports of the current buffer.
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"-- coc-fzf
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []
" Mappings for CocList
nnoremap <silent><nowait> <space>a  :<C-u>CocFzfList actions<CR>
nnoremap <silent><nowait> <space>c  :<C-u>CocFzfList commands<CR>
nnoremap <silent><nowait> <space>da :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent><nowait> <space>db :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent><nowait> <space>e  :<C-u>CocFzfList extensions<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocFzfList outline<CR>
nnoremap <silent><nowait> <space>s  :<C-u>CocFzfList symbols<CR>
" Quick buffer switching
nnoremap <silent><nowait> gb        :<C-u>CocCommand fzf-preview.Buffers<CR>
" Mappings for coc-git
nnoremap <silent><nowait> <space>f  :<C-u>CocCommand fzf-preview.GitFiles<CR>
nnoremap <silent><nowait> <space>gl :<C-u>CocCommand fzf-preview.GitLogs<CR>
nnoremap <silent><nowait> <space>gs :<C-u>CocCommand fzf-preview.GitStatus<CR>
"-- /coc-fzf
"-- /coc.vim


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


"-- bufferline
if has('termguicolors')
    set termguicolors
endif

let g:bufferline_echo = 0

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '#W %R',
      \'z'    : '#H'}


"-- vim-sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
"-- /vim-sneak


"-- vim-terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
"--/ vim-terraform


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


"-- theme
let g:moonlight_borders = 0
let g:moonlight_contrast = 0
syntax enable
filetype plugin indent on
colorscheme codedark
let g:airline_theme = 'codedark'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = 'L'
let g:airline_symbols.colnr = 'C'
let g:airline_symbols.dirty = '!'
let g:airline_section_z = airline#section#create_right(['%p%%'])
"-- /theme


" Clear search highlighting
nnoremap <silent> <A-/> :let @/=""<CR>

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

