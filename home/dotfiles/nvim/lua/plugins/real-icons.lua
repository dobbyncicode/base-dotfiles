return {
	"Mirsmog/real-icons.nvim",
		build = ":RealIcons install",
		dependencies = {
			"nvim-neo-tree/neo-tree.nvim",
		},
		opts = {
			integrations = {
				neo_tree = true,
		},
	},
}
