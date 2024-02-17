local opts = nil
local cmdline_post = function()
    utils.keymap("c", "<Tab>", "<Tab>")
    utils.keymap("c", "<S-Tab>", "<S-Tab>")
    utils.keymap("c", "<C-n>", "<C-n>")
    utils.keymap("c", "<C-p>", "<C-p>")
    utils.keymap("c", "<C-y>", "<C-y>")
    utils.keymap("c", "<C-e>", "<C-e>")
end
local cmdline_pre = function()
    utils.keymap("c", "<Tab>", "<Cmd>call pum#map#insert_relative(+1)<CR>")
    utils.keymap("c", "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>")
    utils.keymap("c", "<C-n>", "<Cmd>call pum#map#insert_relative(+1)<CR>")
    utils.keymap("c", "<C-p>", "<Cmd>call pum#map#insert_relative(-1)<CR>")
    utils.keymap("c", "<C-y>", "<Cmd>call pum#map#confirm()<CR>")
    utils.keymap("c", "<C-e>", "<Cmd>call pum#map#cancel()<CR>")

    -- vim.cmd([[autocmd User DDCCmdlineLeave ++once call CommandlinePost()]])
    utils.make_autocmds({
        augroup = "DDCCmdline",
        autocmds = {
            { event = "CmdlineLeave", opts = { callback = cmdline_post, once = true } },
        },
    })
    vim.fn["ddc#enable_cmdline_completion"]()
end

-- utils.make_autocmds({
--     augroup = "print",
--     autocmds = {
--         {
--             event = "CmdlineEnter",
--             opts = {
--                 -- echo getcmdtype()
--                 callback = function()
--                     if vim.fn.getcmdtype() == ":" then
--                         vim.cmd([[hafkadjlfk]])
--
--                     elseif vim.fn.getcmdtype() == "/" then
--                         vim.cmd([[skaldja;ljklj]])
--                     end
--                 end,
--             },
--         },
--     },
-- })


--
-- ddc completion
--
local spec = {
    {
        "Shougo/ddc.vim",
        dependencies = {
            "vim-denops/denops.vim",
            "Shougo/pum.vim",
            "Shougo/ddc-ui-pum",
            -- "Shougo/ddc-ui-native",
            "Shougo/ddc-source-nvim-lsp",
            "Shougo/ddc-source-around",
            "Shougo/ddc-source-rg",
            "LumaKernel/ddc-source-file",
            "Shougo/ddc-source-cmdline",
            "Shougo/ddc-source-cmdline-history",
            "vim-skk/skkeleton",

            -- filter and sorter and converter
            "tani/ddc-fuzzy",

            -- preview
            "matsui54/denops-popup-preview.vim",
            "matsui54/denops-signature_help",
        },
        -- event = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineEnter", "CmdWinEnter", "ModeChanged" },
        -- event = { "CmdlineEnter" },
        config = function()
            vim.fn["ddc#custom#patch_global"] {
                ui = "pum",
                sources = { "nvim-lsp", "file", "around", "rg", "skkeleton" },
                cmdlineSources = {
                    [":"] = { "cmdline", "cmdline-history", "file", "around" },
                    ['/'] = { "rg", "file", "around" },
                },
                autoCompleteEvents = {
                    "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged", "CmdlineEnter",
                },
                sourceOptions = {
                    _ = {
                        matchers = { "matcher_fuzzy" },
                        sorters = { "sorter_fuzzy" },
                        converters = { "converter_fuzzy" },
                        ignoreCase = true,
                        isVolatile = true,
                    },
                    skkeleton = {
                        isVolatile = true,
                        mark = "skk",
                        matchers = { "skkeleton" },
                        sorters = {},
                        minAutoCompleteLength = 2,
                    },
                    ["nvim-lsp"] = {
                        mark = "lsp",
                        forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
                    },
                    around = {
                        mark = "a",
                    },
                    rg = {
                        mark = "rg",
                    },
                    cmdline = {
                        mark = "cmd",
                        minAutoCompleteLength = 1,
                    },
                    ["cmdline-history"] = {
                        mark = "hist",
                    },
                    file = {
                        mark = "file",
                    },
                },
                sourceParams = {
                    around = { maxSize = 500 },
                },
                uiParams = {
                    pum = { insert = false },
                },
            }
            vim.fn["ddc#enable"]()
        end,
    },
    {
        "Shougo/pum.vim",
        cmd = { "PumToggle" },
        keys = {
            utils.keymap("n", ":", "<Cmd>call CmdlinePre()<CR>:", opts, true),
            utils.keymap("i", "<C-n>", "<Cmd>call pum#map#insert_relative(+1)<CR>", opts, true),
            utils.keymap("i", "<C-p>", "<Cmd>call pum#map#insert_relative(-1)<CR>", opts, true),
            utils.keymap("i", "<C-y>", "<Cmd>call pum#map#confirm()<CR>", opts, true),
            utils.keymap("i", "<C-e>", "<Cmd>call pum#map#cancel()<CR>", opts, true),
            utils.keymap("i", "<PageDown>", "<Cmd>call pum#map#insert_relative_page(+1)<CR>", opts, true),
            utils.keymap("i", "<PageUp>", "<Cmd>call pum#map#insert_relative_page(-1)<CR>", opts, true),
        },
        config = function()
            vim.fn["pum#set_option"] {
                border = "rounded",
                padding = false,
            }


            vim.cmd([[
                function! CmdlinePre() abort
                    cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
                    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
                    cnoremap <expr> <C-n> pum#visible() ? pum#map#insert_relative(+1) : '<Down>'
                    cnoremap <expr> <C-p> pum#visible() ? pum#map#insert_relative(-1) : '<Up>'
                    cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
                    " cmap <expr><CR>   pum#visible() ? '<C-y>' : '<CR>'
                    cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
                    autocmd User DDCCmdlineLeave ++once call CommandlinePost()
                    call ddc#enable_cmdline_completion()
                endfunction

                function! CommandlinePost() abort
                    silent! cunmap <Tab>
                    silent! cunmap <S-Tab>
                    silent! cunmap <C-n>
                    silent! cunmap <C-p>
                    silent! cunmap <C-y>
                    silent! cunmap <CR>
                    silent! cunmap <C-e>
                endfunction
            ]])
        end,
    },
    {
        "matsui54/denops-popup-preview.vim",
        config = function()
            vim.fn["popup_preview#enable"]()
        end,
    },
    {
        "matsui54/denops-signature_help",
        config = function()
            vim.fn["signature_help#enable"]()
        end,
    },
    {
        "vim-skk/skkeleton",
        dependencies = {
            "vim-denops/denops.vim",
        },
        config = function()
            utils.keymap("i", "<C-j>", "<Plug>(skkeleton-toggle)", { silent = true })

            utils.make_autocmds({
                augroup = "skkeleton",
                autocmds = {
                    {
                        event = "User",
                        opts = {
                            pattern = "skkeleton-initialize-pre",
                            callback = function()
                                vim.fn["skkeleton#config"] {
                                    globalJisyo = "~/.xdg/data/skk/SKK-JISYO.L",
                                    eggLikeNewline = true,
                                }
                            end
                        },
                    },
                },
            })
        end,
    }
}

return spec
