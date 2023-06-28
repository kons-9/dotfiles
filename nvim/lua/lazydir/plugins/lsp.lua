
local augroup = vim.api.nvim_create_augroup('UserLspConfig', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(ev)
    local opts = function(config)
      config.silent = true
      config.noremap = true
      config.buffer = ev.buf
      return config
    end
    utils.keymap('n', 'gD', vim.lsp.buf.declaration, opts{ desc = "Go to declaration"})
    utils.keymap('n', 'gd', vim.lsp.buf.definition, opts{ desc = "Go to definition"})
    utils.keymap('n', 'gi', vim.lsp.buf.implementation, opts{ desc = "Go to implementation"})
    utils.keymap('n', 'gr', vim.lsp.buf.references, opts{ desc = "Go to references"})
    utils.keymap('n', 'gt', vim.lsp.buf.type_definition, opts{ desc = "Go to type definition"})

    utils.keymap('n', 'K', vim.lsp.buf.hover, opts{ desc = "Show hover"})
    utils.keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts{ desc = "Show signature help"})

    utils.keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts{ desc = "Add workspace folder"})
    utils.keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts{ desc = "Remove workspace folder"})
    utils.keymap('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts{ desc = "List workspace folders"})

    utils.keymap('n', '<leader>lr', vim.lsp.buf.rename, opts{ desc = "Rename"})
    utils.keymap('n', '<leader>la', vim.lsp.buf.code_action, opts{ desc = "Code action"})
    utils.keymap('n', '<leader>lf', vim.lsp.buf.format, opts{ desc = "Format"})

  end,
})

local spec =  {
  {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason.nvim'},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {'williamboman/mason.nvim', 'neovim/nvim-lspconfig'},
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies={
      {'nvim-lua/plenary.nvim'},
    },
    config = function ()
      local null_ls = require('null-ls')
      local sources = {
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.dart_format,
        null_ls.builtins.formatting.clang_format,
      }

      null_ls.setup({
        sources = sources,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function () 
              vim.lsp.buf.format {async = false}
            end,
            buffer = bufnr,
          })
        end
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    dependencies = {'neovim/nvim-lspconfig'},
    build = ":MasonUpdate",
    config = function()
      utils.safe_require('mason', function(m)
        m.setup()
      end)
      utils.safe_require('mason-lspconfig', function(m)
        m.setup()
      end)

      -- local compatability = require("mason.compatability")

      -----------------------
      -----------------------
      -- lsp server config --
      -----------------------
      -----------------------

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      local data_path = vim.fn.stdpath("data") .. "/mason"

      local function register_lsp(lspname, config)
        local ok, lspconfig = utils.safe_require('lspconfig')
        if not ok then
          return
        end

        local lsp = lspconfig[lspname]
        if config == nil then
          config = {}
        end
        config.flags = lsp_flags
        if lsp then
          lsp.setup(config)
        end
      end

      register_lsp('pyright', {})
      register_lsp('dartls', {})
      register_lsp('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim', 'hs' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
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
          },
        },
      })
      register_lsp('csharp_ls')
      register_lsp('tsserver')
      register_lsp('rust_analyzer')
      register_lsp('ccls', {
        init_options = {
          compilationDatabaseDirectory = "build",
          index = {
            threads = 0,
          },
          clang = {
            excludeArgs = { "-frounding-math" },
          },
        }
      })
      register_lsp('clangd', {
        init_options = {
          clangdFileStatus = true,
        }
      })
      register_lsp('gopls')

      vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { link = "Comment" })

    end,
    keys = {
      {'<leader>e', vim.diagnostic.open_float, mode="n", desc="Open diagnostics"},
      {'<leader>q', vim.diagnostic.setloclist, mode="n", desc="Set loclist"},
      {'[d', vim.diagnostic.goto_prev, mode="n", desc="Go to previous diagnostic"},
      {']d', vim.diagnostic.goto_next, mode="n", desc="Go to next diagnostic"},
    }
  }
}
return spec
