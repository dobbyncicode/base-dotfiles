-- --- [ i ] - Keybinds -
local vars = require("lua-modules.ux.variables")

local mainMod = vars.mainMod
local terminal = vars.terminal
local browser = vars.browser
local file_manager = vars.file_manager
local volume_control = vars.volume_control

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " SHIFT + Return", hl.dsp.exec_cmd("[float; move 15% 5%; size 70% 60%] " .. terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " SHIFT + F", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(volume_control))
hl.bind(mainMod .. " + Space", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Control_R", hl.dsp.global("caelestia:launcher"), { locked = true })

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " Control + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " Control + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " Control + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " Control + down", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + I", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(", XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"))
hl.bind(", XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"))
hl.bind(", XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.global("caelestia:brightnessUp"))
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.global("caelestia:brightnessDown"))
