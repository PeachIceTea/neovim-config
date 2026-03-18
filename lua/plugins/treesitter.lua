return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"rust",
				"javascript",
				"angular",
				"typescript",
				"java",
				"lua",
				"gleam",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" },
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	}
}
