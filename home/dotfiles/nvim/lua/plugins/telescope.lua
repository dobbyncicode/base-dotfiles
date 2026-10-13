return {
	enabled = true,
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "find files" },
	},

}
