local spec =  {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
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
  },
  {
    "preservim/vim-indent-guides",
    config = function() 
      vim.g.indent_guides_enable_on_vim_startup = 1
      vim.g.indent_guides_auto_colors = 0
      vim.g.indent_guides_guide_size = 1
      vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, { command="hi IndentGuidesOdd ctermbg=239" })
      vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, { command="hi IndentGuidesEven ctermbg=237" })
    end,
  },
  {
    'akinsho/nvim-bufferline.lua',
    opts = {}
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
      }

  }
}
return spec
