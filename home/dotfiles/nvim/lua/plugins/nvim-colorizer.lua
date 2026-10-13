return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		user_default_options = {
			names = true,
			RGB = true,
			RRGGBB = true,
			css = true,
			mode = "background",
			tailwind = true,
			hsl = true,
			rgba = true,

		},
	},
}
