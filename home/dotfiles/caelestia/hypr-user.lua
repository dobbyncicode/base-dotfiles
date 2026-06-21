-- --- [ i ] - Caelestia User Config (Lua) -

local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.config/custom-dotfiles/hypr/?.lua"

-- --- [ i ] - UX Section -
require("lua-modules.ux.variables")
require("lua-modules.ux.no-u")
require("lua-modules.ux.monitors")
require("lua-modules.ux.keybinds")
require("lua-modules.ux.inputs")
require("lua-modules.ux.cursor")
require("lua-modules.ux.env")
require("lua-modules.ux.auto-start")

-- --- [ i ] - UI Section -
require("lua-modules.ui.decorations")
require("lua-modules.ui.animations")
require("lua-modules.ui.miscs")
require("lua-modules.ui.borders")

-- --- [ i ] - Exemption Section -
require("lua-modules.ux.window-rules")
