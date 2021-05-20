call plug#begin('~/.config/nvim/plugins')

" NeoVim specific settings here
Plug 'airblade/vim-gitgutter'
"Plug 'bling/vim-bufferline'
Plug 'cdelledonne/vim-cmake'
Plug 'easymotion/vim-easymotion'
"Plug 'edkolev/tmuxline.vim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'folke/which-key.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kshenoy/vim-signature'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
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


lua require('gitsigns').setup()


"-- treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
    ensure_intalled = { 'c', 'cpp', 'dockerfile', 'go', 'java', 'json', 'lua', 'python', 'rust', 'typescript', 'yaml' },
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    }
}
EOF
"-- /treesitter


lua require('telescope').load_extension('coc')


" \d to perform a Dash lookup
nnoremap <leader>d :Dash<cr>


" Shortcut to open nvim-tree
nnoremap <Leader>t :NvimTreeToggle<CR>


" 2021-05-13 Trying out vimspector
let g:vimspector_enable_mappings = 'HUMAN'


" Some sane defaults for navigating multiple windows
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"-- coc.vim
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set updatetime=100  " ms

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>a :CocCommand clangd.switchSourceHeader<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

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

" Mappings for CocList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"--/ coc.vim


"-- fzf
nnoremap <silent><leader>ff :Files<CR>
nnoremap <silent><leader>fd :Files<space>
nnoremap <silent><leader>fu :Rg <C-R><C-W><CR>
nnoremap <silent><leader>fw :Rg<CR>
nnoremap <silent><leader>o :History<CR>
"-- /fzf


" Specify the fuzzy finder that Dashboard uses
let g:dashboard_default_executive = 'fzf'


" Nvim-tree
let g:nvim_tree_side = 'left'
let g:nvim_tree_width = 50
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_open = 0
let g:nvim_tree_auto_close = 0
let g:nvim_tree_quit_on_open = 0
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_hide_dotfiles = 1
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

" Move to previous/next
nnoremap <silent> [b :bp<CR>
nnoremap <silent> ]b :bn<CR>
" Quick buffer switching
nnoremap gb :Buffers<CR>
"-- /bufferline


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


"-- theme
let g:moonlight_borders = 0
let g:moonlight_contrast = 0
syntax enable
filetype plugin indent on
colorscheme codedark
let g:airline_theme = 'codedark'
"-- /theme


" Clear search highlighting
nnoremap <silent> <A-/> :let @/=""<CR>


" Allow loading local, project-specific .nvimrc files
set exrc
" ... but disallow autocommands
set secure

