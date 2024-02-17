-- local keymap = utils.keymap
local spec = {
    {
        "Shougo/ddu-commands.vim",
        keys = {
            --
            -- most used
            --

            { "<leader><leader>ff", "<Cmd>Ddu file_rec<CR>", desc = "Find files",  mode = "n" },
            { "<leader><leader>fg", "<Cmd>Ddu rg<CR>",       desc = "grep files",  mode = "n" },
            { "<leader><leader>fo", "<Cmd>Ddu mr<CR>",       desc = "Find mr",     mode = "n" },
            { "<leader><leader>fb", "<Cmd>Ddu buffer<CR>",   desc = "Find buffer", mode = "n" },

            --
            -- file
            --

            { "<leader>fff",        "<Cmd>Ddu file_rec<CR>", desc = "Find files",  mode = "n" },
            { "<leader>ffg",        "<Cmd>Ddu rg<CR>",       desc = "grep files",  mode = "n" },
            { "<leader>ffb",        "<Cmd>Ddu buffer<CR>",   desc = "Find buffer", mode = "n" },
            { "<leader>ffo",        "<Cmd>Ddu mr<CR>",       desc = "Find mr",     mode = "n" },

            --
            -- lsp
            --

            {
                "<leader>flr", "<Cmd>Ddu lsp_references<CR>", desc = "Find lsp references", mode = "n"
            },
            {
                "<leader>fls", "<Cmd>Ddu lsp_documentSymbols<CR>", desc = "Find lsp document symbols", mode = "n"
            },
            {
                "<leader>flw", "<Cmd>Ddu lsp_workspaceSymbols<CR>", desc = "Find lsp workspace symbols", mode = "n"
            },
            {
                "<leader>fla", "<Cmd>Ddu lsp_codeAction<CR>", desc = "Find lsp code action", mode = "n"
            },
            {
                "<leader>flD", "<Cmd>Ddu lsp_definitions<CR>", desc = "Find lsp definitions", mode = "n"
            },
            {
                "<leader>fld", "<Cmd>Ddu lsp_diagnostic<CR>", desc = "Find lsp diagnostic", mode = "n"
            },


            --
            -- edit
            --

            { "<leader>fsh", "<Cmd>Ddu help<CR>",        desc = "Find help",        mode = "n" },
            { "<leader>fsm", "<Cmd>Ddu man<CR>",         desc = "Find man",         mode = "n" },
            { "<leader>fxc", "<Cmd>Ddu colorscheme<CR>", desc = "Find colorscheme", mode = "n" },

        }

    },
    {
        "Shougo/ddu.vim",
        config = function()
            local lines = vim.opt.lines:get()
            local columns = vim.opt.columns:get()

            vim.fn['ddu#custom#patch_global'] {
                ui = "ff",
                sync = true,
                uiParams = {
                    ff = {
                        previewFloating = true,
                        previewSplit = "vertical",
                        previewHeight = lines - 8,
                        previewWidth = math.floor(columns * 3 / 8),
                        previewRow = 3,
                        previewCol = math.floor(columns / 2),
                        filterSplitDirection = "floating",
                        filterFloatingTitlePos = "right",
                        filterFloatingPosition = "bottom",

                        floatingBorder = "rounded",
                        floatingBorderTitle = "ddu!",
                        previewFloatingBorder = "rounded",

                        winWidth = math.floor(columns * 6 / 8),
                        winCol = math.floor(columns / 8),
                        winRow = 3,
                        winHeight = lines - 8,

                        split = "floating",
                        startFilter = true,
                        -- autoAction = {
                        --     name = "preview",
                        --     params = {
                        --         preview = true,
                        --     },
                        --     sync = true,
                        -- },
                        -- startAutoAction = true,
                        prompt = "> ",
                    }
                },
                sources = {
                    file_rec = {
                        expandSymlinks = true,
                        ignoredDirectories = { ".git", "venv", ".vscode", ".ccls-cache", "target", ".embuild", "build" },
                    },
                    rg = {
                        args = { "--json" },
                    },
                },
                sourceOptions = {
                    _ = {
                        matchers = { "matcher_fzf" },
                        ignoreCase = true,
                    },
                    rg = {
                        matchers = { "converter_display_word" },
                        volatile = true,
                    },
                },
                filterParams = {
                    matcher_fzf = {
                        highlightMatched = "Search",
                    },
                },
                kindOptions = {
                    file = {
                        defaultAction = "open",
                    },
                    help = {
                        defaultAction = "open",
                    },
                },
                kindParams = {
                    help = {
                        command = "vsplit",
                    },
                },
            }
        end
    },
    {
        "Shougo/ddu-ui-ff",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "ddu-ff",
                callback = function()
                    local keymap = function(mode, lhs, rhs, opts)
                        vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
                    end

                    keymap("n", "<CR>", "<Cmd>call ddu#ui#ff#do_action('itemAction')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "<Space>", "<Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "i", "<Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "p", "<Cmd>call ddu#ui#ff#do_action('preview')<CR>",
                        { noremap = true, silent = true })

                    keymap("n", ":q<CR>", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "q", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "<C-e>", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "<esc>", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { noremap = true, silent = true })
                end,
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "ddu-ff-filter",
                callback = function()
                    local keymap = function(mode, lhs, rhs, opts)
                        vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
                    end
                    keymap("i", "<CR>", "<esc><Cmd>call ddu#ui#ff#do_action('itemAction')<CR>",
                        { noremap = true, silent = true })
                    keymap("i", "<esc>", "<esc><Cmd>close<CR>", { silent = true })
                    keymap("i", "<C-d>", "<Cmd>call ddu#ui#ff#do_action('preview')<CR>", { noremap = true })
                    keymap("i", "<C-n>", "<Cmd>call ddu#ui#do_action('cursorNext')<CR>", { noremap = true })
                    keymap("i", "<C-p>", "<Cmd>call ddu#ui#ff#do_action('cursorPrevious')<CR>", { noremap = true })

                    keymap("i", "<C-e>", "<esc><Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { noremap = true, silent = true })
                end,
            })
        end
    },
    {
        "Shougo/ddu-source-file_rec",
    },
    {
        "Shougo/ddu-source-file_old",
    },
    {
        "shun/ddu-source-rg",
    },
    {
        "Shougo/ddu-source-buffer",
    },
    {
        "matsui54/ddu-source-help",
    },
    {
        "kuuote/ddu-source-mr",
    },
    {
        "matsui54/ddu-source-man",
    },
    {
        "4513ECHO/ddu-source-colorscheme",
    },
    {
        "Shougo/ddu-filter-converter_display_word",
    },
    {
        "Shougo/ddu-filter-matcher_substring",
    },
    {
        "yuki-yano/ddu-filter-fzf",
    },
    {
        "Shougo/ddu-kind-file",

    },
    {
        "Shougo/ddu-kind-file",
    },
    {
        "uga-rosa/ddu-source-lsp",
    },
}
return spec
