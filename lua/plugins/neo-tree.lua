return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = {
					width = 30,
					mappings = {
						["l"] = "open",
						["h"] = "close_node",
						["O"] = {
							function(state)
								local node = state.tree:get_node()
								local path = node:get_id()
								vim.fn.jobstart({ "xdg-open", path }, { detach = true })
							end,
							desc = "Open with system application",
						},
					},
				},
				filesystem = {
					filtered_items = {
						hide_dotfiles = true,
						hide_gitignored = true,
					},
					follow_current_file = {
						enabled = true,
					},
				},
			})

			vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
		end,
	},
}
