local spec = {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "iceberg_dark",
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = { "filename", "branch", "diagnostics" },
                lualine_c = { "os.date('%y/%m/%d %H:%M:%S')" },
                lualine_x = { "encoding", "fileformat" },
                lualine_y = { "filetype", "progress" },
                lualine_z = {
                    "location",
                },
            },
            inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },
            tabline = {},
            extensions = {},
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            utils.safe_require("bufferline", function(m)
                local bufferline = m
                bufferline.setup({
                    options = {
                        style_preset = {
                            bufferline.style_preset.no_italic
                        },
                        diagnostics = "nvim_lsp",
                        diagnostics_indicator = function(count, level, diagnostics_dict, context)
                            local icon = level:match("error") and " " or " "
                            return " " .. icon .. count
                        end,
                        indicator = {
                            style = 'underline',
                        },

                    },
                })
            end)
        end,
    },
}
return spec
