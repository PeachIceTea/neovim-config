return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
				},
			})
		end,
	},
}
