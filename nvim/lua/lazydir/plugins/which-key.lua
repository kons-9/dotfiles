local spec = {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 100
        end,
        config = function()
            utils.safe_require("which-key", function(wk)
                wk.setup({})
                wk.register({
                    ["<leader>"] = {
                        d = { name = "Debug" },
                        f = {
                            name = "Fuzzy Finder('telescope')",
                            f = { name = "File" },
                            e = { name = "Edit" },
                            s = { name = "Search" },
                            m = { name = "Move" },
                            c = { name = "Command" },
                            l = { name = "Lsp" },
                            g = { name = "Git" },
                            x = { name = "etc" },
                        },
                        g = { name = "LSP GoTo" },
                        l = { name = "LSP etc" },
                        s = { name = "Session" },
                        t = { name = "tree" },
                        w = { name = "LSP Workspace" },
                        ["<C-t>"] = { name = "Toggle terminal" },
                        ["<leader>"] = {
                            name = "Frequent use tool",
                            f = { name = "FF File" },
                            -- e = { name = "Edit" },
                            -- s = { name = "Search" },
                            -- m = { name = "Move" },
                            -- c = { name = "Command" },
                            l = { name = "FF Lsp" },
                            -- g = { name = "Git" },
                            -- x = { name = "etc" },
                        },
                    },
                })
            end)
        end,
    },
}

return spec
