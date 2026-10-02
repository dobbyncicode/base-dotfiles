-- --- [ i ] - Animations -
hl.config({
	animations = {
		enabled = true,
	}
})

hl.curve("ease-in-out", { type = "bezier", points = { {0.4, 0.0}, {0.2, 1.0} } })
hl.curve("springy-pop", { type = "bezier", points = { {0.34, 1.56}, {0.64, 1.0} } })
hl.curve("soft-deceleration", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0} } })
hl.curve("cinematic", { type = "bezier", points = { {0.76, 0}, {0.24, 1} } })
hl.curve("ultra-smooth-delay", { type = "bezier", points = { {0.45, 0}, {0.55, 1.0} } })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "springy-pop" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 6, bezier = "ease-in-out" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "soft-deceleration" })
hl.animation({ leaf = "layers", enabled = true, speed = 6, bezier = "ultra-smooth-delay" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "ultra-smooth-delay" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "soft-deceleration" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "cinematic" })
