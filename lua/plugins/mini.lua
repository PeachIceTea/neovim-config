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

			vim.keymap.set("n", "<leader>bc", function()
				local bufremove = require("mini.bufremove")
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
						bufremove.delete(buf, false)
					end
				end
			end, { desc = "Close all buffers" })

			vim.keymap.set("n", "<leader>bo", function()
				local bufremove = require("mini.bufremove")
				local current = vim.api.nvim_get_current_buf()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and buf ~= current then
						bufremove.delete(buf, false)
					end
				end
			end, { desc = "Close all other buffers" })
		end,
	},
}
