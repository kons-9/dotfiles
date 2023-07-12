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

      local layout = {
        { type = "padding", val = 1 },
        section.header,
        { type = "padding", val = 2 },
        section.restore_session,
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

  },

}
return spec
