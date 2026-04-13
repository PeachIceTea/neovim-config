return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
			highlight = "ibl_indent",
		},
		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			highlight = "ibl_scope",
		},
	},
	config = function(_, opts)
		vim.api.nvim_set_hl(0, "ibl_indent", { fg = "#928374" })
		vim.api.nvim_set_hl(0, "ibl_scope", { fg = "#fe8019" })
		require("ibl").setup(opts)
	end,
}
