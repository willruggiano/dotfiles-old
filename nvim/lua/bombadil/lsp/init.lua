local nvim_lsp = require "lspconfig"
local lspconfig_util = require "lspconfig.util"
local nvim_status = require "lsp-status"

local nnoremap = vim.keymap.nnoremap
local telescope_mapper = require "bombadil.telescope.mappings"

_ = require("lspkind").init()

require("bombadil.lsp.status").activate()

local handlers = require "bombadil.lsp.handlers"

local on_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Mappings.
  nnoremap { "gd", vim.lsp.buf.definition, buffer = 0 }
  nnoremap { "gD", vim.lsp.buf.declaration, buffer = 0 }
  nnoremap { "gT", vim.lsp.buf.type_definition, buffer = 0 }
  nnoremap { "gi", vim.lsp.buf.implementation, buffer = 0 }

  nnoremap { "<space>dl", vim.lsp.diagnostic.show_line_diagnostics, buffer = 0 }
  nnoremap { "<space>dn", vim.lsp.diagnostic.goto_next, buffer = 0 }
  nnoremap { "<space>dp", vim.lsp.diagnostic.goto_prev, buffer = 0 }

  nnoremap { "<space>rn", vim.lsp.buf.rename, buffer = 0 }
  nnoremap { "K", vim.lsp.buf.hover, buffer = 0 }

  nnoremap {
    "<space>rr",
    function()
      vim.lsp.stop_client(vim.lsp.get_active_clients())
      vim.cmd [[e]]
    end,
    buffer = 0,
  }

  telescope_mapper("gr", "lsp_references", {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = true,
  }, true)

  telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

  telescope_mapper("<space>ca", "lsp_code_actions", nil, true)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.codeLens = {
  dynamicRegistration = false,
}
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

nvim_lsp.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--suggest-missing-includes",
  },
  on_init = on_init,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    nnoremap { "<leader>a", "<cmd>ClangdSwitchSourceHeader<cr>", buffer = 0 }
  end,
  init_options = {
    clangdFileStatus = true,
    completeUnimported = true,
    semanticHighlighting = true,
    usePlaceholders = true,
  },
  handlers = nvim_status.extensions.clangd.setup(),
  capabilities = updated_capabilities,
}

nvim_lsp.cmake.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

nvim_lsp.pyright.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

local lua_lspconfig = {
  cmd = { "lua-language-server" },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = updated_capabilities,
  root_dir = function(fname)
    if string.find(vim.fn.fnamemodify(fname, ":p"), "dotfiles/nvim") then
      return vim.fn.expand "~/dotfiles/nvim"
    end

    return lspconfig_util.find_git_ancestors(fname) or lspconfig_util.path.dirname(fname)
  end,
  globals = {
    -- Colorbuddy
    "Color",
    "c",
    "Group",
    "g",
    "s",
    -- Custom (see bombadil.globals)
    "RELOAD",
  },
}

nvim_lsp.sumneko_lua.setup(require("lua-dev").setup { lspconfig = lua_lspconfig })

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
