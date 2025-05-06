return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                float = {
                    -- Padding around the floating window
                    padding = 2,
                    max_width = 0,
                    max_height = 0,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    override = function(conf)
                        return conf
                    end,
                },
            })
            vim.keymap.set("n", "<leader>tt", "<cmd>lua require('oil').open()<CR>", { desc = "Open oil", silent = true })
            vim.keymap.set("n", "<leader>tf", "<cmd>lua require('oil').toggle_float()<CR>",
                { desc = "Open float oil", silent = true })
        end,
    },
}
