-- nvim-cmp
--
local spec = {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "uga-rosa/cmp-dictionary",
            'lukas-reineke/cmp-rg',
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        event = {
            "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged", "CmdlineEnter",
        },
        config = function()
            utils.safe_require("cmp", function(cmp)
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            vim.fn["vsnip#anonymous"](args.body)
                        end,
                    },
                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                    },
                    mapping = cmp.mapping.preset.insert({
                        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<C-e>"] = cmp.mapping.abort(),
                        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "nvim_lsp_signiture_help" },
                        { name = "vsnip" },
                    }, {
                        { name = "path" },
                        {
                            name = "buffer",
                            option = {
                                keyword_length = 2,
                                get_bufnrs = function()
                                    return vim.api.nvim_list_bufs()
                                end

                            }
                        },
                        { name = "rg" },
                    }),
                })
                cmp.setup.filetype("gitcommit", {
                    sources = cmp.config.sources({
                        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                    }, {
                        { name = "buffer" },
                        { name = "rg" },
                    }),
                })
                cmp.setup.filetype("markdown", {
                    sources = cmp.config.sources({
                        { name = "dictionary" },
                        { name = "buffer" },
                        { name = "rg" },
                    })
                })

                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline({ "/", "?" }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "buffer" },
                        { name = "rg" },
                    },
                })

                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(":", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "path" },
                    }, {
                        { name = "cmdline" },
                    }),
                })
            end)
        end,
    },
}
return spec
