-- local keymap = utils.keymap
local spec = {
    {
        "Shougo/ddu-commands.vim",
        keys = {
            -- nnoremap <silent> <leader>fo <Cmd>Ddu file_old<CR>
            -- nnoremap <silent> <leader>fg <Cmd>Ddu rg<CR>
            -- nnoremap <silent> <leader>fb <Cmd>Ddu buffer<CR>
            -- nnoremap <silent> <leader>fh <Cmd>Ddu help<CR>
            -- nnoremap <silent> <leader>fr <Cmd>Ddu mr<CR>
            -- nnoremap <silent> <leader>fm <Cmd>Ddu man<CR>
            -- nnoremap <silent> <leader>fc <Cmd>Ddu colorscheme -ui-param-winWidth=&columns*3/4<CR>
            { "<leader>ff", "<Cmd>Ddu file_rec<CR>",    desc = "Find files",       mode = "n" },
            { "<leader>fg", "<Cmd>Ddu rg<CR>",          desc = "grep files",       mode = "n" },
            { "<leader>fb", "<Cmd>Ddu buffer<CR>",      desc = "Find buffer",      mode = "n" },
            { "<leader>fh", "<Cmd>Ddu help<CR>",        desc = "Find help",        mode = "n" },
            { "<leader>fr", "<Cmd>Ddu mr<CR>",          desc = "Find mr",          mode = "n" },
            { "<leader>fm", "<Cmd>Ddu man<CR>",         desc = "Find man",         mode = "n" },
            { "<leader>fc", "<Cmd>Ddu colorscheme<CR>", desc = "Find colorscheme", mode = "n" },
        }

    },
    {
        "Shougo/ddu.vim",
        config = function()
            local lines = vim.opt.lines:get()
            local columns = vim.opt.columns:get()

            vim.fn['ddu#custom#patch_global'] {
                ui = "ff",
                uiParams = {
                    ff = {
                        previewFloating = true,
                        previewSplit = "vertical",
                        previewHeight = lines - 8,
                        previewWidth = math.floor(columns * 3 / 8),
                        previewRow = 3,
                        filterSplitDirection = "floating",
                        winWidth = math.floor(columns * 3 / 4),
                        winCol = math.floor(columns / 8),
                        winRow = 3,
                        winHeight = lines - 8,
                        split = "floating",
                        startFilter = true,
                        autoAction = {
                            name = "preview",
                        },
                        prompt = ">> ",
                    }
                },
                sources = {
                    file_rec = {
                        expandSymlinks = true,
                        ignoredDirectories = { ".git", "venv", ".vscode", ".ccls-cache", "target", ".embuild" },
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
                    keymap("n", ":q<CR>", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { noremap = true, silent = true, buffer = true })
                    keymap("n", "q", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "p", "<Cmd>call ddu#ui#ff#do_action('preview')<CR>",
                        { noremap = true, silent = true })
                    keymap("n", "<C-e>", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>",
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
                    keymap("i", "<C-e>", "<esc><Cmd>call ddu#ui#ff#do_action('quit')<CR>",
                        { norermap = true, silent = true })
                    keymap("i", "<C-d>", "<Cmd>call ddu#ui#ff#do_action('preview')<CR>", { noremap = true })
                    keymap("i", "<C-n>", "<Cmd>call ddu#ui#ff#execute('call cursor(line('.'+1),0)<Bar>redraw')<CR>",
                        { noremap = true })
                    keymap("i", "<C-p>", "<Cmd>call ddu#ui#ff#execute('call cursor(line('.'-1),0)<Bar>redraw')<CR>",
                        { noremap = true })
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
        "Shougo/ddu-kind-file"
    },
}
return spec
