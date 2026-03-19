return {
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		keys = {
			{
				"<leader>fr",
				function()
					require("grug-far").open()
				end,
				desc = "Search and replace",
			},
			{
				"<leader>fw",
				function()
					require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
				end,
				desc = "Search and replace word under cursor",
			},
		},
	},
}
