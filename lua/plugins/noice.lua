return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			routes = {
				{
					filter = {
						event = "lsp",
						kind = "progress",
						find = "Validate documents",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "lsp",
						kind = "progress",
						find = "Publish diagnostics",
					},
					opts = { skip = true },
				},
			},
		},
		keys = {
			{ "<leader>mn", "<cmd>NoiceAll<cr>", desc = "Noice all messages" },
			{ "<leader>md", "<cmd>NoiceDismiss<cr>", desc = "Dismiss notifications" },
		},
	},
}
