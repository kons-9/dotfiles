local spec = {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			utils.keymap("n", "<leader><C-t>", "<cmd>ToggleTerm size=20<CR>", { desc = "Toggle terminal" }, true),
			utils.keymap("t", "<C-t>", "<C-\\><C-n>:ToggleTermToggleAll<CR>", { desc = "Toggle all terminal" }, true),
		},
		cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll", "ToggleTermToggleAll" },
		config = function()
			-- utils.keymap("n", "<C-`>", ":ToggleTerm size=20<CR>", { desc = "Toggle terminal" })
			-- utils.keymap("t", "<C-`>", "<C-\\><C-n>:ToggleTermToggleAll<CR>", { desc = "Toggle all terminal" })
			-- utils.keymap('n', '<leader>t', '<cmd>ToggleTerm size=20<CR>', {desc = 'Toggle terminal'})
			-- utils.keymap('t', '<C-@>', '<C-\\><C-n>:ToggleTermToggleAll<CR>', {desc = 'Toggle all terminal'})
			require("toggleterm").setup({})
		end,
	},
}
return spec
