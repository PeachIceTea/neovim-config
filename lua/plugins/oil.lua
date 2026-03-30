return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"refractalize/oil-git-status.nvim",
		},
		config = function()
			require("oil").setup({
				win_options = {
					signcolumn = "yes:2",
				},
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["gr"] = "actions.refresh",
				},
			})

			require("oil-git-status").setup()

			vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open file explorer" })
		end,
	},
}
