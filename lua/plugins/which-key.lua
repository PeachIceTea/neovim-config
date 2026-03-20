return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{ "<leader>m", group = "messages" },
				{ "<leader>b", group = "buffers" },
				{ "<leader>t", group = "terminal" },
				{ "<leader>f", group = "find" },
				{ "<leader>l", group = "lsp" },
				{ "<leader>g", group = "git" },
			},
		},
	},
}
