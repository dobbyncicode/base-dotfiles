-- --- [ i ] - Window Rules -
hl.window_rule({
    name = "browser-things",
    match = { class = "^([Ff]irefox|[Gg]oogle-[Cc]hrome|[Bb]rave-[Bb]rowser|[Cc]hromium)$" },
    opacity = { 0.90, 0.85 },
})

hl.window_rule({
    name = "float-work-popups",
    match = { initial_title = "^(about:blank - Brave|Untitled - Brave|Brave)$" },
    float = true,
    size = { 1080, 800 },
    center = true,
    monitor = "DP-1",
})

hl.window_rule({
    name = "file-management",
    match = { class = "^([Tt]hunar|xdg-desktop-portal-gtk|yazi-float)$" },
    float = true,
    center = true,
    size = { 1080, 800 },
    monitor = "DP-1",
    no_follow_mouse = true,
})

hl.window_rule({
    name = "small-process",
    match = { title = "^[Ff]ile [Oo]peration [Pp]rocess$" },
    float = true,
    center = true,
    size = { 625, 120 },
    monitor = "DP-1",
    no_follow_mouse = true,
})

hl.window_rule({
    name = "torrent-float",
    match = { initial_class = "^(org.qbittorrent.qBittorrent)$" },
    float = true,
    center = true,
    size = { 1080, 800 },
    monitor = "DP-1",
    no_follow_mouse = true,
})
