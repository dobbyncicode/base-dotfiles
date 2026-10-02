function tsdrop
    if not tailscale status >/dev/null 2>&1
        echo "setting up tailscale permissions for you real quick..."
        sudo tailscale set --operator=$USER >/dev/null 2>&1
    end

    switch "$argv[1]"
        case send
            set file_to_send $argv[2]
            set target_device $argv[3]
            if test -z "$file_to_send"
                set file_to_send (fzf --prompt="pick a file > ")
                if test -z "$file_to_send"; return; end
            end
            if test -z "$target_device"
                set target_device (tailscale status | awk 'NR>1 {print $2}' | fzf --prompt="send to which device? > ")
                if test -z "$target_device"; return; end
            end
            echo "sending $file_to_send to $target_device..."
            tailscale file cp $file_to_send "$target_device:" 2>&1 | tr '\r' '\n' | awk '
                /ETA/ { next }
                NF > 1 {
                    gsub(/  +/, " | ")
                    printf "\r\033[K sending %s", $0
                    fflush()
                }
            '
            echo ""
            echo "sent $file_to_send to $target_device"
        case get
            set target_folder $argv[2]
            if test -z "$target_folder"
                set target_folder "."
            end
            tailscale file get $target_folder
            echo "got $target_folder"
        case '*'
            echo "usage: 'tsdrop send [file] [device]' or 'tsdrop get [folder]'"
    end
end
