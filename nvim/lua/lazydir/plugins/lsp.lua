return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason.nvim'},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {'williamboman/mason.nvim', 'neovim/nvim-lspconfig'},
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


      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local function bufopts(desc)
          if desc == nil then
            desc = true
          end
          return { norermap = true, silent = true, buffer = bufnr, desc = desc }
        end

        utils.keymap('n', 'gD', vim.lsp.buf.declaration, bufopts("Go to declaration"))
        utils.keymap('n', 'gd', vim.lsp.buf.definition, bufopts("Go to definition"))
        utils.keymap('n', 'gi', vim.lsp.buf.implementation, bufopts("Go to implementation"))
        utils.keymap('n', 'gr', vim.lsp.buf.references, bufopts("Go to references"))
        utils.keymap('n', 'gt', vim.lsp.buf.type_definition, bufopts("Go to type definition"))

        utils.keymap('n', 'K', vim.lsp.buf.hover, bufopts("Show hover"))
        utils.keymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts("Show signature help"))

        utils.keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts("Add workspace folder"))
        utils.keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts("Remove workspace folder"))
        utils.keymap('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts("List workspace folders"))

        utils.keymap('n', '<leader>lr', vim.lsp.buf.rename, bufopts("Rename"))
        utils.keymap('n', '<leader>la', vim.lsp.buf.code_action, bufopts("Code action"))
        utils.keymap('n', '<leader>lf', vim.lsp.buf.formatting, bufopts("Format"))

        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = vim.lsp.buf.formatting_sync,
          buffer = bufnr
        })
        -- client.server_capabilities.semanicTokensProvider = nil
      end

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
        config.on_attach = on_attach
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
