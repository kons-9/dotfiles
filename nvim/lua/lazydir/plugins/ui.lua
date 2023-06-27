return {
  {
    "nvim-lualine/lualine.nvim",
    config = function() 
      -- status line
      -- Bubbles config for lualine
      -- Author: lokesh-krishna
      -- MIT license, see LICENSE for more details.

      -- stylua: ignore
      local colors = {
        blue   = '#80a0ff',
        cyan   = '#79dac8',
        black  = '#080808',
        white  = '#c6c6c6',
        red    = '#ff5189',
        violet = '#d183e8',
        grey   = '#303030',
      }

      require('lualine').setup {
        options = {
          theme = 'iceberg_dark',
          -- component_separators = '|',
          -- section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            -- { 'mode', separator = { left = '' }, right_padding = 2 },
            'mode'
          },
          lualine_b = { 'filename', 'branch', 'diagnostics' },
          lualine_c = {},
          lualine_x = {'encoding', 'fileformat'},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            'location'
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
  {
    "nathanaelkane/vim-indent-guides",
    config = function() 
      vim.g.indent_guides_enable_on_vim_startup = 1
      vim.g.indent_guides_auto_colors = 0
      vim.g.indent_guides_guide_size = 1
      vim.api.nvim_create_augroup('indent', {})
      vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, { group="indent", command="hi IndentGuidesOdd ctermbg=239" })
      vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, { group="indent", command="hi IndentGuidesEven ctermbg=237" })
    end,
  },
  {
    "morhetz/gruvbox",
  }

}
