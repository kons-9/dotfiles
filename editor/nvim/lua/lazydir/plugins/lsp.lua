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
    },
    {
        "williamboman/mason.nvim",
        dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
        build = ":MasonUpdate",
        config = function()
            local lsps = {
                { "ts_ls",         {} },
                { "lua_ls", {
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
                } },
                { "rust_analyzer", {} },
                { "clangd", {
                    init_options = {
                        clangdFileStatus = true,
                    },
                } },
                { "verible", {
                    cmd = {
                        "verible-verilog-ls",
                        "--indentation_spaces=4", "--column_limit=100", "--rules_config_search",
                        -- "--port_declarations_indentation=indent", "--formal_parameters_indentation=indent",
                        -- "--expand_coverpoints",
                    }
                } },
            }

            local names_of_servers = {}
            for _, lsp in ipairs(lsps) do
                names_of_servers[#names_of_servers + 1] = lsp[1]
            end

            utils.safe_require("mason", function(m)
                m.setup()
            end)
            utils.safe_require("mason-lspconfig", function(m)
                m.setup {
                    automatic_installation = true,
                    ensure_installed = names_of_servers,
                }
            end)

            for _, lsp in ipairs(lsps) do
                vim.lsp.config(lsp[1], lsp[2])
            end
            vim.lsp.enable(names_of_servers)

            -- vim.cmd [[set completeopt+=menuone,noselect,popup]]
            vim.lsp.start({
                name = 'ts_ls',
                cmd = { 'typescript-language-server', '--stdio' },
                on_attach = function(client, bufnr)
                    vim.lsp.completion.enable(true, client.id, bufnr, {
                        autotrigger = true, -- 自動補完を有効にする
                        convert = function(item)
                            return { abbr = item.label:gsub('%b()', '') }
                        end,
                    })
                end,
            })
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('my.lsp', {}),
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    -- if client:supports_method('textDocument/implementation') then
                    --     -- Create a keymap for vim.lsp.buf.implementation ...
                    -- end
                    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
                    if client:supports_method('textDocument/completion') then
                        -- Optional: trigger autocompletion on EVERY keypress. May be slow!
                        -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                        -- client.server_capabilities.completionProvider.triggerCharacters = chars
                        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                    end
                    -- Auto-format ("lint") on save.
                    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
                    if not client:supports_method('textDocument/willSaveWaitUntil')
                        and client:supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                            end,
                        })
                    end
                end,
            })

            vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { link = "Comment" })
        end,
        keys = {
        },
    },
}
return spec
