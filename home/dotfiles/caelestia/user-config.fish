mise activate fish | source

# --- [ i ] - Abbr section ---
abbr di "dotdrop install --cfg=/home/dobby/aa/config.yaml"
abbr dr "sudo dotdrop install --cfg=/home/dobby/aa/config-root.yaml"
abbr gac --set-cursor "git add . && git commit -m \"%\""
abbr upo "yay -Syyu --noconfirm && poweroff"
abbr upr "yay -Syyu --noconfirm && reboot"

# --- [ i ] - Environment variables section ---
set -gx EDITOR {{@@ editor @@}}
set -gc VISUAL {{@@ editor @@}}

# --- [ i ] - Function section ---
