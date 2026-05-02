eval (~/.local/bin/eap activate fish | string collect)
{%@@ if profile == "localhost" @@%}
starship init fish | source

alias apt="nala"
alias ls="eza --icons --group-directories-first -1"
{%@@ endif @@%}

{%@@ if profile != "localhost" @@%}
fzf --fish | source
{%@@ endif @@%}

# --- [ i ] - Abbr section ---
{%@@ if profile == "localhost" @@%}
abbr upup "apt upgrade --assume-yes --full"
{%@@ endif @@%}
{%@@ if profile != "localhost" @@%}
abbr upo "yay -Syyu --noconfirm && poweroff"
abbr upr "yay -Syyu --noconfirm && reboot"
abbr dr "sudo dotdrop install --cfg={{@@ _dotdrop_dotpath.rsplit('/', 1)[0] @@}}/config-root.yaml"
{%@@ endif @@%}

abbr ddi "dotdrop install --cfg={{@@ _dotdrop_cfgpath @@}}"
abbr ddu "dotdrop update --cfg={{@@ _dotdrop_cfgpath @@}}"
abbr gac --set-cursor "git add . && git commit -m \"%\""
abbr gp "git push -u origin main"
abbr lla "ls -la"
abbr tla "tree -la -I '.git'"

# --- [ i ] - Function section ---

function yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
function tsdrop
    if not tailscale status >/dev/null 2>&1
        echo "🔑 setting up tailscale permissions for you real quick..."
        sudo tailscale set --operator=$USER >/dev/null 2>&1
    end

    switch "$argv[1]"
        case send
            set file_to_send $argv[2]
            set target_device $argv[3]

            if test -z "$file_to_send"
                set file_to_send (fzf --prompt="📄 pick a file to send > ")
                if test -z "$file_to_send"; return; end 
            end

            if test -z "$target_device"
                set target_device (tailscale status | awk 'NR>1 {print $2}' | fzf --prompt="💻 send to which device? > ")
                if test -z "$target_device"; return; end
            end
            echo "⏳ sending $file_to_send to $target_device..."
            
            tailscale file cp $file_to_send "$target_device:" 2>&1 | tr '\r' '\n' | awk '
                /ETA/ { next }
                NF > 1 {
                    gsub(/  +/, " │ ")
                    printf "\r\033[K🚀 %s", $0
                    fflush()
                }
            '
            echo "" 
            echo "🚀 sent $file_to_send to $target_device"
            
        case get
            set target_folder $argv[2]
            
            if test -z "$target_folder"
                set target_folder "."
            end
            
            tailscale file get $target_folder
            echo "📥 saved files to $target_folder"
            
        case '*'
            echo "❌ usage: 'tsdrop send [file] [device]' or 'tsdrop get [folder]'"
    end
end

function vol
    if test (count $argv) -eq 0
        pactl get-sink-volume @DEFAULT_SINK@
    else
        pactl set-sink-volume @DEFAULT_SINK@ $argv[1]
    end
end

function media
    switch $argv[1]
        case play pause
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
