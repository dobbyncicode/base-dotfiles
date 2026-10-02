function media
    switch $argv[1]
        case play\ pause
            playerctl play-pause
        case next
            playerctl next
        case prev
            playerctl previous
        case stop
            playerctl stop
        case '*'
            echo "usage: media [play|pause|next|prev|stop]"
    end
end
