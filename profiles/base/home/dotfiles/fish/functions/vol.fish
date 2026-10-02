function vol
    if test (count $argv) -eq 0
        pactl get-sink-volume @DEFAULT_SINK@
    else
        pactl set-sink-volume @DEFAULT_SINK@ $argv[1]
    end
end
