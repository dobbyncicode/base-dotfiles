-- --- [ i ] - Keybinds -
local vars = require("lua-modules.ux.variables")

local mainMod = vars.mainMod
local terminal = vars.terminal
local browser = vars.browser
local file_manager = vars.file_manager
local volume_control = vars.volume_control
local code_editor = vars.code_editor
local screenshot = vars.screenshot
local clipboard = vars.clipboard
local emoji_picker = vars.emoji_picker
local screenrecord = vars.screenrecord

-- ── Applications (Priority 1) ──

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("[float; move 15% 5%; size 70% 60%] " .. browser))

hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(code_editor))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("[float; move 15% 5%; size 70% 60%] " .. code_editor))

hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(file_manager))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("[float; move 15% 5%; size 70% 60%] " .. file_manager))

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("[float; move 15% 5%; size 70% 60%] " .. terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("[float; move 15% 5%; size 70% 60%] " .. terminal))

-- ── Utilities (Priority 2) ──

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(screenrecord))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot .. " area"))
hl.bind(mainMod .. " + ALT + SHIFT + S", hl.dsp.exec_cmd(screenrecord .. " -g \"$(slurp)\""))

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(emoji_picker))

hl.bind("CTRL + Control_R", hl.dsp.global("caelestia:launcher"), { release = true })

-- ── Audio (Priority 2) ──

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(volume_control))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("[float; move 15% 5%; size 70% 60%] " .. volume_control))

-- ── Window State (Priority 3) ──

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch killactive"))
hl.bind(mainMod .. " + Space", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + CTRL + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

-- ── Layout (Priority 4) ──

hl.bind(mainMod .. " + L", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("layout_picker"))
hl.bind(mainMod .. " + O", hl.dsp.layout("swapsplit"))

-- ── Navigation ──

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + ALT + left", hl.dsp.exec_cmd("hyprctl dispatch focusmonitor l"))
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("hyprctl dispatch focusmonitor r"))
hl.bind(mainMod .. " + ALT + up", hl.dsp.exec_cmd("hyprctl dispatch focusmonitor u"))
hl.bind(mainMod .. " + ALT + down", hl.dsp.exec_cmd("hyprctl dispatch focusmonitor d"))

hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 50, y = 0 }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -50 }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 50 }))

-- ── Workspaces ──
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ── Mouse ──

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Media Keys ──

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.global("caelestia:brightnessUp"))
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.global("caelestia:brightnessDown"))
