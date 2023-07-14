local spec = {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "iceberg_dark",
        -- component_separators = '|',
        -- section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          -- { 'mode', separator = { left = '' }, right_padding = 2 },
          "mode",
        },
        lualine_b = { "filename", "branch", "diagnostics" },
        lualine_c = {},
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
        autocmd VimEnter,Colorscheme * hi IndentGuidesOdd guibg=239 ctermbg=239
        autocmd VimEnter,Colorscheme * hi IndentGuidesEven guibg=237 ctermbg=237
      ]])
      vim.cmd("call indent_guides#enable()")

      -- vim.api.nvim_create_autocmd(
      -- 	{ "VimEnter", "ColorScheme" },
      -- 	{ command = "hi IndentGuidesOdd guibg=239 ctermbg=239" }
      -- )
      -- vim.api.nvim_create_autocmd(
      -- 	{ "VimEnter", "ColorScheme" },
      -- 	{ command = "hi IndentGuidesEven guibg=237 ctermbg=237" }
      -- )
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
  -- {
  -- 	"folke/noice.nvim",
  -- 	dependencies = {
  -- 		"MunifTanjim/nui.nvim",
  -- 		"rcarriga/nvim-notify",
  -- 	},
  -- 	opts = {
  -- 		messages = {
  -- 			view_error = "messages",
  -- 		},
  -- 		lsp = {
  -- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  -- 			override = {
  -- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  -- 				["vim.lsp.util.stylize_markdown"] = true,
  -- 				["cmp.entry.get_documentation"] = true,
  -- 			},
  -- 		},
  -- 		-- you can enable a preset for easier configuration
  -- 		presets = {
  -- 			bottom_search = true, -- use a classic bottom cmdline for search
  -- 			command_palette = true, -- position the cmdline and popupmenu together
  -- 			long_message_to_split = true, -- long messages will be sent to a split
  -- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
  -- 			lsp_doc_border = false, -- add a border to hover docs and signature help
  -- 		},
  -- 		views = {
  -- 			cmdline_popup = {
  -- 				position = {
  -- 					row = "20%",
  -- 					col = "50%",
  -- 				},
  -- 			},
  -- 		},
  -- },
  -- },
}
return spec
