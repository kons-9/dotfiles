local augroup = vim.api.nvim_create_augroup("UserLspConfig", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
        local opts = function(config)
            config.silent = true
            config.noremap = true
            config.buffer = ev.buf
            return config
        end
        utils.keymap("n", "gD", vim.lsp.buf.declaration, opts({ desc = "Go to declaration" }))
        utils.keymap("n", "gd", vim.lsp.buf.definition, opts({ desc = "Go to definition" }))
        utils.keymap("n", "gi", vim.lsp.buf.implementation, opts({ desc = "Go to implementation" }))
        utils.keymap("n", "gr", vim.lsp.buf.references, opts({ desc = "Go to references" }))
        utils.keymap("n", "gt", vim.lsp.buf.type_definition, opts({ desc = "Go to type definition" }))

        utils.keymap("n", "K", vim.lsp.buf.hover, opts({ desc = "Show hover" }))
        utils.keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts({ desc = "Show signature help" }))

        utils.keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts({ desc = "Add workspace folder" }))
        utils.keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts({ desc = "Remove workspace folder" }))
        utils.keymap("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts({ desc = "List workspace folders" }))

        utils.keymap("n", "<leader>lr", vim.lsp.buf.rename, opts({ desc = "Rename" }))
        utils.keymap("n", "<leader>la", vim.lsp.buf.code_action, opts({ desc = "Code action" }))
        utils.keymap("n", "<leader>lf", vim.lsp.buf.format, opts({ desc = "Format" }))
    end,
})

local spec = {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim" },
        -- event = "VimEnter",
    },
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     dependencies = {
    --         { "nvim-lua/plenary.nvim" },
    --     },
    --     event = "BufWritePre",
    --     config = function()
    --         local null_ls = require("null-ls")
    --         local sources = {
    --             null_ls.builtins.formatting.rustfmt,
    --             null_ls.builtins.formatting.autopep8,
    --             null_ls.builtins.formatting.dart_format,
    --             -- null_ls.builtins.formatting.clang_format,
    --             null_ls.builtins.formatting.stylua,
    --             null_ls.builtins.diagnostics.eslint,
    --             null_ls.builtins.completion.spell,
    --         }
    --
    --         null_ls.setup({
    --             sources = sources,
    --             -- on_attach = function(client, bufnr)
    --             --     vim.api.nvim_create_autocmd("BufWritePre", {
    --             --         callback = function()
    --             --             vim.lsp.buf.format({ async = false })
    --             --         end,
    --             --         buffer = bufnr,
    --             --     })
    --             -- end,
    --         })
    --     end,
    -- },
    {
        "akinsho/flutter-tools.nvim",
        cmd = "FlutterRun",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
    {
        "williamboman/mason.nvim",
        dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
        build = ":MasonUpdate",
        config = function()
            utils.safe_require("mason", function(m)
                m.setup()
            end)
            utils.safe_require("mason-lspconfig", function(m)
                m.setup()
            end)

            -----------------------
            -----------------------
            -- lsp server config --
            -----------------------
            -----------------------

            local function register_lsp(lspname, config)
                if config == nil then
                    config = {}
                end
                -- Set up lspconfig.
                local lsp_flags = {
                    debounce_text_changes = 150,
                }
                config.flags = lsp_flags

                -- connect to nvim-cmp
                local ok, cmp_nvim_lsp = utils.safe_require("cmp_nvim_lsp")
                if ok then
                    local capabilities = cmp_nvim_lsp.default_capabilities()
                    config.capabilities = capabilities
                end

                -- connect to lspconfig
                local ok, lspconfig = utils.safe_require("lspconfig")
                if not ok then
                    return
                end

                local lsp = lspconfig[lspname]
                if lsp then
                    lsp.setup(config)
                end
            end

            register_lsp("pyright", {})
            -- register_lsp("dartls", {})
            register_lsp("lua_ls", {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim", "hs" },
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
            register_lsp("ts_ls")
            -- register_lsp("csharp_ls")
            -- register_lsp("tsserver")
            register_lsp("rust_analyzer")
            -- register_lsp("ccls", {
            --   init_options = {
            --     compilationDatabaseDirectory = "build",
            --     index = {
            --       threads = 0,
            --     },
            --     clang = {
            --       excludeArgs = { "-frounding-math" },
            --     },
            --   },
            -- })
            register_lsp("clangd", {
                init_options = {
                    clangdFileStatus = true,
                },
            })
            register_lsp("verible", {
                cmd = {
                    "verible-verilog-ls",
                    "--indentation_spaces=4", "--column_limit=100", "--rules_config_search",
                    -- "--port_declarations_indentation=indent", "--formal_parameters_indentation=indent",
                    -- "--expand_coverpoints",
                }

            })
            -- register_lsp("svls", {
            --     root_dir = function(fname)
            --         return require("lspconfig.util").find_git_ancestor(fname)
            --     end,
            --     cmd = { "svls", "-d" },
            -- })
            register_lsp("gopls")

            vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { link = "Comment" })
        end,
        keys = {
            { "<leader>e", vim.diagnostic.open_float, mode = "n", desc = "Open diagnostics" },
            { "<leader>q", vim.diagnostic.setloclist, mode = "n", desc = "Set loclist" },
            { "[d",        vim.diagnostic.goto_prev,  mode = "n", desc = "Go to previous diagnostic" },
            { "]d",        vim.diagnostic.goto_next,  mode = "n", desc = "Go to next diagnostic" },
        },
    },
}
return spec
