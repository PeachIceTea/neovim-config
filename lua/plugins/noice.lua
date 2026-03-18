return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		keys = {
			{ "<leader>mn", "<cmd>NoiceAll<cr>", desc = "Noice all messages" },
			{ "<leader>md", "<cmd>NoiceDismiss<cr>", desc = "Dismiss notifications" },
		},
	},
}
