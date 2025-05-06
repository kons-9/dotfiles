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
        "preservim/vim-indent-guides",
        config = function()
            vim.g.indent_guides_enable_on_vim_startup = 1
            vim.g.indent_guides_auto_colors = 0
            vim.g.indent_guides_guide_size = 1
            vim.cmd([[
                autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#808080 ctermbg=23
                autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#303030 ctermbg=23
            ]])
            vim.cmd("call indent_guides#enable()")
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
            utils.safe_require("fidget", function(m)
                m.setup()
            end
            )
        end
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
