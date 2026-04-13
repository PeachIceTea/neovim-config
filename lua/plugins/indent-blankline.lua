return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
			highlight = "Whitespace",
		},
		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			highlight = "Comment",
		},
	},
}
