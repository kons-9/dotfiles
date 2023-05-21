-----------------------
-----------------------
-- installer setting --
-----------------------
-----------------------

require("mason").setup()
require("mason-lspconfig").setup({
  -- ensure_installed = { "sumneko_lua", "rust_analyzer", "taplo", "ccls" },
  automatic_installation = true,
})

--------------
--------------
-- General Mappings --
--------------
--------------

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', '<leader>fmt', vim.lsp.buf.formatting, bufopts)
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = vim.lsp.buf.formatting_sync,
    buffer = bufnr
  })
end

-----------------------
-----------------------
-- lsp server config --
-----------------------
-----------------------

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


require('lspconfig')['pyright'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    python = {
      -- pythonPath = '/usr/local/bin/python3.11',
      analysis = {
        -- autoSearchPaths = true,
        -- diagnosticMode = "workspace",
      },
    }
  }
}


require('lspconfig')['lua_ls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "4",
          tab_width = "4",
        },
      },
    }
  },
  -- capabilities = capabilities
}

require('lspconfig')['omnisharp_mono'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  cmd = { "mono", "~/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp/OmniSharp.exe" },
  enable_roslyn_analyzers = true,
  enable_import_completion = true,
}

require('lspconfig')['tsserver'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["tsserver"] = {
    },
  },
  -- capabilities = capabilities
}
require('lspconfig')['rust_analyzer'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {
    },
  },
  -- capabilities = capabilities
}
require('lspconfig')['grammarly'].setup {
  on_attach = on_attach,
  init_options = {
    clientId = "client_JspPpK94Xy57ZM463XJqkz",
  }
}

require 'lspconfig'['ccls'].setup {
  init_options = {
    compilationDatabaseDirectory = "build",
    index = {
      threads = 0,
    },
    clang = {
      excludeArgs = { "-frounding-math" },
    },
  }
}

