-- --- [ i ] - monitors config driven by variables.yaml + uservariables.yaml -
local monitor_setup = {{@@ monitor_setup @@}}

-- --- [ i ] - helper to get transform value -
local function get_transform(orientation)
    if orientation == "portrait" then
        return 1
    elseif orientation == "landscape" then
        return 0
    else
        return 0
    end
end

-- --- [ i ] - effective dims considering orientation + scale -
local function eff_dims(width, height, scale, orientation)
    if orientation == "portrait" then
        return (height * scale), (width * scale)
    else
        return (width * scale), (height * scale)
    end
end

-- --- [ i ] - build monitors table from variables -
local monitors = {}

table.insert(monitors, {
    port     = "{{@@ monitor1_port @@}}",
    width    = {{@@ monitor1_width @@}},
    height   = {{@@ monitor1_height @@}},
    refresh  = {{@@ monitor1_refresh @@}},
    scale    = {{@@ monitor1_scale @@}},
    position = "{{@@ monitor1_position @@}}",
    orientation = "{{@@ monitor1_orientation @@}}",
})

if monitor_setup >= 2 then
    table.insert(monitors, {
        port     = "{{@@ monitor2_port @@}}",
        width    = {{@@ monitor2_width @@}},
        height   = {{@@ monitor2_height @@}},
        refresh  = {{@@ monitor2_refresh @@}},
        scale    = {{@@ monitor2_scale @@}},
        position = "{{@@ monitor2_position @@}}",
        orientation = "{{@@ monitor2_orientation @@}}",
    })
end

-- --- [ i ] - find main monitor by position -
local main_monitor = nil
for _, m in ipairs(monitors) do
    if m.position == "main" then
        main_monitor = m
        break
    end
end

-- --- [ i ] - fallback if no main set -
if not main_monitor then
    for _, m in ipairs(monitors) do
        hl.monitor({
            output = m.port ~= "" and m.port or "",
            mode   = "preferred",
            position = "auto",
            scale  = 1,
            transform = 0,
        })
    end
else
    -- --- [ i ] - main dims for relative placement -
    local main_w_eff, main_h_eff = eff_dims(
        main_monitor.width, main_monitor.height,
        main_monitor.scale, main_monitor.orientation
    )

    -- --- [ i ] - generate configs relative to main -
    for _, m in ipairs(monitors) do
        local port = m.port
        local mode_str = m.width .. "x" .. m.height .. "@" .. m.refresh
        local position_str
        local transform_val = get_transform(m.orientation)

        if m == main_monitor then
            position_str = "0x0"
        else
            local w_eff, h_eff = eff_dims(
                m.width, m.height, m.scale, m.orientation
            )

            local x = 0
            local y = main_h_eff - h_eff

            if m.position == "left" then
                x = -w_eff
            elseif m.position == "right" then
                x = main_w_eff
            else
                x = main_w_eff
            end

            position_str = math.floor(x) .. "x" .. math.floor(y)
        end

        hl.monitor({
            output = port,
            mode = mode_str,
            position = position_str,
            scale = m.scale,
            transform = transform_val,
        })
    end

    -- --- [ i ] - workspace rules: main gets 1+2, next gets 3 -
    local second_port = nil
    for _, m in ipairs(monitors) do
        if m ~= main_monitor then
            second_port = m.port
            break
        end
    end

    hl.workspace_rule({ workspace = "1", monitor = main_monitor.port, default = true })
    hl.workspace_rule({ workspace = "2", monitor = main_monitor.port, default = true })
    if second_port and second_port ~= "" then
        hl.workspace_rule({ workspace = "3", monitor = second_port, default = true })
    end
end
