mise activate fish | source

# --- [ i ] - Abbr section ---
abbr di "dotdrop install --cfg={{@@ _dotdrop_cfgpath @@}}/config.yaml"
abbr dr "sudo dotdrop install --cfg={{@@ _dotdrop_cfgpath @@}}/config-root.yaml"
abbr gac --set-cursor "git add . && git commit -m \"%\""
abbr upo "yay -Syyu --noconfirm && poweroff"
abbr upr "yay -Syyu --noconfirm && reboot"
abbr gp "git push -u origin main"

# --- [ i ] - Environment variables section ---
set -gx EDITOR {{@@ editor @@}}
set -gc VISUAL {{@@ editor @@}}

# --- [ i ] - Function section ---
