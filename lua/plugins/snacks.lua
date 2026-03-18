return {
	{
		"folke/snacks.nvim",
		opts = {
			lazygit = {
				enabled = true,
				win = {
					style = "layzgit",
					position = "float",
					height = 0.9,
					width = 0.9,
				},
			},
			terminal = { enabled = true, win = { position = "bottom", height = 0.3 } },
		},
		keys = {
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>tt",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle terminal",
			},
		},
	},
}
