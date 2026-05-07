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
            local cmp = require("cmp")
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
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "vsnip" },
                }, {
                    { name = "path" },
                    {
                        name = "buffer",
                        option = {
                            keyword_length = 2,
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end,
                        },
                    },
                    { name = "rg" },
                }),
            })
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
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
                }),
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                    { name = "rg" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
return spec
