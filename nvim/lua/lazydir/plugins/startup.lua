local spec = {
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local startify = require("alpha.themes.startify")
            local section = startify.section
            local button = startify.button
            section.restore_session = {
                type = "group",
                val = {
                    button("s", "Use latest session", "<cmd>SessionRestore<CR>"),
                }
            }
            section.oil = {
                type = "group",
                val = {
                    button("o", "Open file tree", "<cmd>Oil<CR>"),
                }
            }

            local layout = {
                { type = "padding", val = 1 },
                section.header,
                { type = "padding", val = 2 },
                section.restore_session,
                section.oil,
                section.top_buttons,
                section.mru_cwd,
                section.mru,
                { type = "padding", val = 1 },
                section.bottom_buttons,
                section.footer,
            }

            local alpha = require('alpha')
            alpha.setup(
                {
                    layout = layout,
                    opts = startify.config.opts,
                }
            )
        end,
        keys = {
            { '<leader>a', '<cmd>Alpha<CR>', desc = "Open startup page", mode = "n" },
        },

    },
}
return spec
