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
  use {
    "rhysd/git-messenger.vim",
    setup = function()
      vim.g.git_messenger_no_default_mappings = 1
    end,
  }

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
    "tzachar/compe-tabnine",
    requires = "hrsh7th/nvim-compe",
    run = "./install.sh",
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
  use "b3nj5m1n/kommentary"
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
        "CHADTree",
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
    "yamatsum/nvim-nonicons",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      vim.g.override_nvim_web_devicons = true
      require("nvim-nonicons").get "file"
    end,
  }
  use "liuchengxu/vista.vim"
  use "simrat39/symbols-outline.nvim"
  use "mildred/vim-bufmru"
  use { "folke/zen-mode.nvim", requires = "folke/twilight.nvim" }
  use {
    "folke/todo-comments.nvim",
    config = function()
      require "bombadil.config.todo"
    end,
  }
  use {
    "tamago324/lir.nvim",
    config = function()
      require "bombadil.config.lir"
    end,
    requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "yamatsum/nvim-nonicons" },
  }
  use { "tamago324/lir-git-status.nvim", requires = "tamago324/lir.nvim" }

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
    rocks = "inspect",
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
  use {
    "nvim-telescope/telescope-arecibo.nvim",
    rocks = { "openssl", "lua-http-parser" },
  }
  use "nvim-telescope/telescope-vimspector.nvim"
end)
