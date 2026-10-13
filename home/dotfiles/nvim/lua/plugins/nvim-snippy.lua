return {
	enabled = true,
	"dcampos/nvim-snippy",
	main = "snippy",
	opts = {
		mappings = {
			is = {
				["<Tab>"] = "expand_or_advance",
				["<S-Tab>"] = "previous",
			},
		},
	},
}
