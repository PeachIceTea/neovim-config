return {
	{
		"nvim-mini/mini.nvim",
		config = function()
			require("mini.surround").setup()
			require("mini.comment").setup()
			require("mini.pairs").setup()
			require("mini.ai").setup()
			require("mini.bufremove").setup()

			vim.keymap.set("n", "<leader>c", function()
				require("mini.bufremove").delete()
			end, { desc = "Close buffer" })
		end,
	},
}
