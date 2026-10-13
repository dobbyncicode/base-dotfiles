return {
	enabled = true,
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},

	keys = {
		{ "<leader>e", "<cmd>NvimTreeOpen<CR>", desc = "open file explorer" },
	},

}
