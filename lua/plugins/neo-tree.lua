return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
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

			-- vim.api.nvim_create_autocmd("WinClosed", {
			-- 	callback = function()
			-- 		vim.schedule(function()
			-- 			local wins = vim.api.nvim_list_wins()
			-- 			local non_neo_tree = vim.tbl_filter(function(w)
			-- 				return vim.bo[vim.api.nvim_win_get_buf(w)].filetype ~= "neo-tree"
			-- 			end, wins)
			-- 			if #wins > 0 and #non_neo_tree == 0 then
			-- 				vim.cmd("qall")
			-- 			end
			-- 		end)
			-- 	end,
			-- })
		end,
	},
}
