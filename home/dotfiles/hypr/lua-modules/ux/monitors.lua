-- --- [ i ] - Monitors -
hl.monitor({
    output = "DP-2",
    mode = "1600x900@60",
    position = "0x-520",
    scale = 1.0,
    transform = 1,
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@60",
    position = "900x0",
    scale = 1.0,
    transform = 0,
})

hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1", default = true })
