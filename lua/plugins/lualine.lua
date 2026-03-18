return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox",
					globalstatus = true,
				},
				extensions = { "neo-tree" },
			})

			vim.o.showmode = false
		end,
	},
}
