vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
  local packer = require "packer"
  local use = packer.use
  local use_rocks = packer.use_rocks

  -- Packer
  use "wbthomason/packer.nvim"

  -- Autoloading for lua
  use "tjdevries/astronauta.nvim"

  -- For when I forget what I'm doing
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end,
  }
  use "rizzatti/dash.vim"

  -- Movement
  use "ggandor/lightspeed.nvim"
  use "kshenoy/vim-signature"

  -- Grep
  use "kevinhwang91/nvim-hlslens"
  use {
    "mg979/vim-visual-multi",
    branch = "master",
  }

  -- Git
  use {
    "TimUntersberger/neogit",
    requires = "sindrets/diffview.nvim",
    config = function()
      require("neogit").setup {
        integrations = {
          diffview = true,
        },
      }
    end,
  }
  use "lewis6991/gitsigns.nvim"
  use "rhysd/git-messenger.vim"
  use "tpope/vim-fugitive"

  -- Lsp, build-test-debug, etc
  use "cdelledonne/vim-cmake"
  use "neovim/nvim-lspconfig"
  use {
    "hrsh7th/nvim-compe",
    requires = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
  }
  use {
    "puremourning/vimspector",
    setup = function()
      vim.g.vimspector_enable_mappings = "HUMAN"
    end,
  }
  use "wbthomason/lsp-status.nvim"
  use "onsails/lspkind-nvim"
  use "glepnir/lspsaga.nvim"
  use "nvim-lua/lsp_extensions.nvim"
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        auto_preview = false,
        auto_fold = true,
      }
    end,
  }
  use "folke/lua-dev.nvim"

  -- Text editing + manipulation
  use "tpope/vim-commentary"
  -- use "tpope/vim-surround"
  use {
    "blackCauldron7/surround.nvim",
    config = function()
      vim.g.surround_mappings_style = "surround"
      require("surround").setup {}
    end,
  }
  use "windwp/nvim-autopairs"
  use {
    "mhartington/formatter.nvim",
    config = function()
      local formatters = require "bombadil.formatter"
      require("formatter").setup {
        logging = false,
        filetype = formatters,
      }
    end,
    rocks = "luafilesystem",
  }

  -- Treesitter/syntax/highlighty things
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  }
  use "hashivim/vim-terraform"
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    cmd = "MarkdownPreview",
  }
  use "kevinoid/vim-jsonc"
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.g.indent_blankline_filetype_exclude = {
        "dashboard",
        "help",
        "man",
        "NvimTree",
        "vimcmake",
      }
    end,
  }
  -- use 'RRethy/vim-illuminate'
  use "zinit-zsh/zinit-vim-syntax"
  use {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("bqf").enable()
    end,
  }

  -- Visual stuff; sidebars, explorers, etc
  use {
    "glepnir/dashboard-nvim",
    config = function()
      vim.g.dashboard_default_executive = "telescope"
    end,
  }
  use {
    "yamatsum/nvim-nonicons",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      vim.g.override_nvim_web_devicons = true
      require("nvim-nonicons").get("file")
    end
  }
  use {
    "kyazdani42/nvim-tree.lua",
    config = require "bombadil.tree",
  }
  use "liuchengxu/vista.vim"
  use "simrat39/symbols-outline.nvim"
  use "mildred/vim-bufmru"
  use { "folke/zen-mode.nvim", requires = "folke/twilight.nvim" }
  use {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {
        signs = false,
      }
    end,
  }

  -- Colors
  use "norcalli/nvim-colorizer.lua"
  use "tjdevries/colorbuddy.nvim"
  use "marko-cerovac/material.nvim"
  use { "tjdevries/express_line.nvim" }
  use {
    "norcalli/nvim-terminal.lua",
    config = function()
      require("terminal").setup()
    end,
  }
  use "folke/tokyonight.nvim"
  use "doums/darcula"

  -- Utilities
  use {
    "nvim-lua/plenary.nvim",
    rocks = "inspect"
  }
  use "nvim-lua/popup.nvim"
  use "tpope/vim-eunuch"
  use "tpope/vim-repeat"
  use {
    "antoinemadec/FixCursorHold.nvim",
    run = function()
      vim.g.curshold_updatime = 1000
    end,
  }

  -- Telescope, et al
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzf-writer.nvim"
  use "nvim-telescope/telescope-packer.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-telescope/telescope-github.nvim"
  use "nvim-telescope/telescope-symbols.nvim"
  use "nvim-telescope/telescope-frecency.nvim"
  use { "nvim-telescope/telescope-cheat.nvim", requires = "tami5/sql.nvim" }
end)
