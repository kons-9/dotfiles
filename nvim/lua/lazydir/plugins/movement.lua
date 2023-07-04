local spec = {
	{
		"t9md/vim-choosewin",
		config = function()
			vim.g.choosewin_overlay_enable = 1
			vim.g.choosewin_overlay_opacity = 50
			utils.keymap("n", "<leader><C-w>", "<Plug>(choosewin)", { desc = "choose window" })
		end,
	},
}
return spec
