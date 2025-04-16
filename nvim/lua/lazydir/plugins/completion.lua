-- nvim-cmp
--
local spec = {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "uga-rosa/cmp-dictionary",
            'lukas-reineke/cmp-rg',

            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        event = {
            "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged", "CmdlineEnter",
        },
        config = function()
            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end
            utils.safe_require("cmp", function(cmp)
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            vim.fn["vsnip#anonymous"](args.body)
                        end,
                    },
                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                    },
                    mapping = cmp.mapping.preset.insert({
                        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<C-e>"] = cmp.mapping.abort(),
                        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "nvim_lsp_signiture_help" },
                        { name = "vsnip" },
                    }, {
                        { name = "path" },
                        {
                            name = "buffer",
                            option = {
                                keyword_length = 2,
                                get_bufnrs = function()
                                    return vim.api.nvim_list_bufs()
                                end

                            }
                        },
                        { name = "rg" },
                    }),
                })
                cmp.setup.filetype("gitcommit", {
                    sources = cmp.config.sources({
                        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                    }, {
                        { name = "buffer" },
                        { name = "rg" },
                    }),
                })
                cmp.setup.filetype("markdown", {
                    sources = cmp.config.sources({
                        { name = "dictionary" },
                        { name = "buffer" },
                        { name = "rg" },
                    })
                })

                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline({ "/", "?" }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "buffer" },
                        { name = "rg" },
                    },
                })

                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(":", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "path" },
                    }, {
                        { name = "cmdline" },
                    }),
                })
            end)
        end,
    },
}

--
-- ddc completion
--
-- local spec = {
--   {
--     "Shougo/ddc.vim",
--     dependencies = {
--       "vim-denops/denops.vim",
--       "Shougo/pum.vim",
--       "Shougo/ddc-ui-pum",
--       -- "Shougo/ddc-ui-native",
--       "Shougo/ddc-source-nvim-lsp",
--       "Shougo/ddc-source-around",
--       "Shougo/ddc-source-rg",
--       "LumaKernel/ddc-source-file",
--       "Shougo/ddc-source-cmdline",
--       "Shougo/ddc-source-cmdline-history",
--
--       -- filter and sorter and converter
--       "tani/ddc-fuzzy",
--
--       -- preview
--       "matsui54/denops-popup-preview.vim",
--       "matsui54/denops-signature_help",
--     },
--     event = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineEnter", "CmdWinEnter", "ModeChanged" },
--     -- event = { "CmdlineEnter" },
--     config = function()
--       vim.cmd([[
--       " Customize global settings
--       call ddc#custom#patch_global({
--           \ 'ui': 'pum',
--           \ 'sources': ['nvim-lsp', 'file', 'around', 'rg'],
--           \ 'cmdlineSources': {
--           \   ':': ['cmdline','cmdline-history', 'file', 'around'],
--           \   '/': ['rg','file', 'around'],
--           \ },
--           \ 'autoCompleteEvents': [
--           \   'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter',
--           \ ],
--           \ 'sourceOptions': #{
--           \   _: #{
--           \     matchers: ['matcher_fuzzy'],
--           \     sorters: ['sorter_fuzzy'],
--           \     converters: ['converter_fuzzy'],
--           \     ignoreCase: v:true,
--           \     isVolatile: v:true,
--           \   },
--           \   nvim-lsp: #{
--           \     mark: 'lsp',
--           \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
--           \     minAutoCompleteLength: 1,
--           \   },
--           \   around: #{
--           \     mark:'a',
--           \   },
--           \   rg: #{
--           \     mark:'rg',
--           \   },
--           \   cmdline: #{
--           \     mark:'cmd',
--           \     minAutoCompleteLength: 1,
--           \   },
--           \   cmdline-history: #{
--           \     mark:'hist',
--           \   },
--           \   file: #{
--           \     mark:'file',
--           \   },
--           \ },
--           \ 'sourceParams' : #{
--           \   around: #{ maxSize: 500 },
--           \ },
--           \ 'uiParams': #{
--           \   pum: #{
--           \     insert: v:false,
--           \   },
--           \ },
--           \ })
--
--       call ddc#enable()
--
--       ]])
--     end,
--   },
--   {
--     "Shougo/pum.vim",
--     cmd = { "PumToggle" },
--     config = function()
--       vim.cmd([[
--         call pum#set_option("border", "rounded")
--         call pum#set_option("padding", v:true)
--
--         nnoremap :       <Cmd>call CommandlinePre()<CR>:
--         inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
--         inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
--         inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
--         inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
--         inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
--         inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>
--
--         " pum settings of command line
--         function! CommandlinePre() abort
--             cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
--             cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
--             cnoremap <expr> <C-n> pum#visible() ? pum#map#insert_relative(+1) : '<Down>'
--             cnoremap <expr> <C-p> pum#visible() ? pum#map#insert_relative(-1) : '<Up>'
--             cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
--             " cmap <expr><CR>   pum#visible() ? '<C-y>' : '<CR>'
--             cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
--
--             autocmd User DDCCmdlineLeave ++once call CommandlinePost()
--
--             " Enable command line completion for the buffer
--             call ddc#enable_cmdline_completion()
--         endfunction
--
--         function! CommandlinePost() abort
--             silent! cunmap <Tab>
--             silent! cunmap <S-Tab>
--             silent! cunmap <C-n>
--             silent! cunmap <C-p>
--             silent! cunmap <C-y>
--             silent! cunmap <CR>
--             silent! cunmap <C-e>
--         endfunction
--       ]])
--     end,
--   },
--   {
--     "matsui54/denops-popup-preview.vim",
--     config = function()
--       vim.cmd([[
--         call popup_preview#enable()
--       ]])
--     end,
--   },
--   {
--     "matsui54/denops-signature_help",
--     config = function()
--       vim.cmd([[
--         call signature_help#enable()
--       ]])
--     end,
--   },
-- }

return spec
