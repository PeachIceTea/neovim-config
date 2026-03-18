return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{ "<leader>m", group = "messages" },
				{ "<leader>b", group = "buffers" },
				{ "<leader>t", group = "terminal" },
				{ "<leader>g", group = "git" },
			},
		},
	},
}
