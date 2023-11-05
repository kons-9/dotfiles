local spec = {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-e>"] = require("telescope.actions").close,
                        },
                    },
                },
            })
        end,
        keys = {
            -- files
            { "<leader>fff", '<cmd>lua require("telescope.builtin").find_files()<cr>', desc = "Find files", mode = "n" },
            {
                "<leader>ffo",
                '<cmd>lua require("telescope.builtin").oldfiles()<cr>',
                desc = "Find old files",
                mode = "n",
            },
            { "<leader>ffg", '<cmd>lua require("telescope.builtin").live_grep()<cr>',  desc = "Grep files", mode = "n" },
            {
                "<leader>ffb",
                '<cmd>lua require("telescope.builtin").buffers()<cr>',
                desc = "Find buffers",
                mode = "n",
            },
            {
                "<leader><leader>ff",
                '<cmd>lua require("telescope.builtin").find_files()<cr>',
                desc = "Find files",
                mode = "n",
            },
            {
                "<leader><leader>fo",
                '<cmd>lua require("telescope.builtin").oldfiles()<cr>',
                desc = "Find old files",
                mode = "n",
            },
            {
                "<leader><leader>fg",
                '<cmd>lua require("telescope.builtin").live_grep()<cr>',
                desc = "Grep files",
                mode = "n",
            },
            {
                "<leader><leader>fb",
                '<cmd>lua require("telescope.builtin").buffers()<cr>',
                desc = "Find buffers",
                mode = "n",
            },

            -- edit
            {
                "<leader>fes",
                '<cmd>lua require("telescope.builtin").spell_suggest()<cr>',
                desc = "Suggest spell",
                mode = "n",
            },
            {
                "<leader>fes",
                '<cmd>lua require("telescope.builtin").quickfix()<cr>',
                desc = "Suggest quickfix",
                mode = "n",
            },

            -- search
            {
                "<leader>fsm",
                '<cmd>lua require("telescope.builtin").man_pages()<cr>',
                desc = "Find man pages",
                mode = "n",
            },
            {
                "<leader>fsh",
                '<cmd>lua require("telescope.builtin").help_tags()<cr>',
                desc = "Find help tags",
                mode = "n",
            },
            { "<leader>fsk", '<cmd>lua require("telescope.builtin").keymaps()<cr>', desc = "Find keymaps", mode = "n" },

            -- movement
            { "<leader>fmm", '<cmd>lua require("telescope.builtin").marks()<cr>',   desc = "Find marks",   mode = "n" },
            {
                "<leader>fmr",
                '<cmd>lua require("telescope.builtin").registers()<cr>',
                desc = "Find registers",
                mode = "n",
            },
            { "<leader>fmt", '<cmd>lua require("telescope.builtin").tags()<cr>',      desc = "Find tags", mode = "n" },
            {
                "<leader>fmf",
                '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>',
                desc = "Find in current buffer",
                mode = "n",
            },

            -- command
            {
                "<leader>fch",
                '<cmd>lua require("telescope.builtin").command_history()<cr>',
                desc = "Find command_history",
                mode = "n",
            },
            {
                "<leader>fcc",
                '<cmd>lua require("telescope.builtin").commands()<cr>',
                desc = "Find commands",
                mode = "n",
            },

            -- lsp
            {
                "<leader>flr",
                '<cmd>lua require("telescope.builtin").lsp_references()<cr>',
                desc = "Lsp references",
                mode = "n",
            },
            {
                "<leader><leader>lr",
                '<cmd>lua require("telescope.builtin").lsp_references()<cr>',
                desc = "Lsp references",
                mode = "n",
            },
            {
                "<leader>flD",
                '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>',
                desc = "Lsp definitions",
                mode = "n",
            },
            {
                "<leader><leader>ld",
                '<cmd>lua require("telescope.builtin").diagnostics()<cr>',
                desc = "Lsp Diagnostics",
                mode = "n",
            },
            {
                "<leader>fld",
                '<cmd>lua require("telescope.builtin").diagnostics()<cr>',
                desc = "Lsp Diagnostics",
                mode = "n",
            },
            {
                "<leader>fli",
                '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>',
                desc = "Lsp lsp_implementations",
                mode = "n",
            },
            {
                "<leader>flt",
                '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>',
                desc = "Lsp type definitions",
                mode = "n",
            },
            {
                "<leader>fls",
                '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>',
                desc = "Lsp document symbols",
                mode = "n",
            },
            {
                "<leader>flw",
                '<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<cr>',
                desc = "Lsp workspace symbols",
                mode = "n",
            },

            -- git
            {
                "<leader>fgc",
                '<cmd>lua require("telescope.builtin").git_commits()<cr>',
                desc = "Git commits",
                mode = "n",
            },
            {
                "<leader>fgb",
                '<cmd>lua require("telescope.builtin").git_branches()<cr>',
                desc = "Git branches",
                mode = "n",
            },
            {
                "<leader>fgB",
                '<cmd>lua require("telescope.builtin").git_bcommits()<cr>',
                desc = "Git buffer commits",
                mode = "n",
            },
            { "<leader>fgS", '<cmd>lua require("telescope.builtin").git_stash()<cr>', desc = "Git stash", mode = "n" },
            {
                "<leader>fgs",
                '<cmd>lua require("telescope.builtin").git_status()<cr>',
                desc = "Git status",
                mode = "n",
            },

            -- etc
            {
                "<leader>fxc",
                '<cmd>lua require("telescope.builtin").colorscheme()<cr>',
                desc = "Find colorscheme",
                mode = "n",
            },
            {
                "<leader>fxf",
                '<cmd>lua require("telescope.builtin").filetypes()<cr>',
                desc = "Find filetypes",
                mode = "n",
            },
        },
    },
    {
        "jvgrootveld/telescope-zoxide",
        after = "telescope.nvim",
        config = function()
            require("telescope").load_extension("zoxide")
        end,
        keys = {
            {
                "<leader>ffz",
                '<cmd>lua require("telescope").extensions.zoxide.list{}<cr>',
                desc = "Find zoxide",
                mode = "n"
            },
            {
                "<leader><leader>fz",
                '<cmd>lua require("telescope").extensions.zoxide.list{}<cr>',
                desc = "Find zoxide",
                mode = "n",
            },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        after = "telescope.nvim",
        config = function()
            require("telescope").load_extension("lazygit")
        end,
        keys = {
            {
                "<leader>fgl",
                '<cmd>lua require("telescope").extensions.lazygit.lazygit{}<cr>',
                desc = "Find lazygit",
                mode = "n",
            },
            {
                "<leader><leader>lg",
                '<cmd>lua require("telescope").extensions.lazygit.lazygit{}<cr>',
                desc = "Find lazygit",
                mode = "n",
            },
        },
    }
}

return spec
