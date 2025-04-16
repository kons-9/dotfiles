local spec = {
    {
        "folke/which-key.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "echasnovski/mini.nvim",
        },
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 100
        end,
        config = function()
            utils.safe_require("which-key", function(wk)
                wk.setup({})
                wk.add({
                    { "<leader><C-t>",     group = "Toggle terminal" },
                    { "<leader><leader>",  group = "Frequent use tool" },
                    { "<leader><leader>f", group = "FF File" },
                    { "<leader><leader>l", group = "FF Lsp" },
                    { "<leader>d",         group = "Debug" },
                    { "<leader>f",         group = "Fuzzy Finder('telescope')" },
                    { "<leader>fc",        group = "Command" },
                    { "<leader>fe",        group = "Edit" },
                    { "<leader>ff",        group = "File" },
                    { "<leader>fg",        group = "Git" },
                    { "<leader>fl",        group = "Lsp" },
                    { "<leader>fm",        group = "Move" },
                    { "<leader>fs",        group = "Search" },
                    { "<leader>fx",        group = "etc" },
                    { "<leader>g",         group = "LSP GoTo" },
                    { "<leader>l",         group = "LSP etc" },
                    { "<leader>s",         group = "Session" },
                    { "<leader>t",         group = "tree" },
                    { "<leader>w",         group = "LSP Workspace" },
                })
            end)
        end,
    },
}

return spec
