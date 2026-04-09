{%@@ if profile == "localhost" @@%}
starship init fish | source
{%@@ endif @@%}

{%@@ if not profile == "localhost" @@%}
mise activate fish | source
{%@@ endif @@%}

# --- [ i ] - Abbr section ---
abbr di "dotdrop install --cfg={{@@ _dotdrop_cfgpath @@}}"
abbr dr "sudo dotdrop install --cfg={{@@ _dotdrop_dotpath.rsplit('/', 1)[0] @@}}/config-root.yaml"
abbr gac --set-cursor "git add . && git commit -m \"%\""
abbr upo "yay -Syyu --noconfirm && poweroff"
abbr upr "yay -Syyu --noconfirm && reboot"
abbr gp "git push -u origin main"

# --- [ i ] - Environment variables section ---
set -gx EDITOR {{@@ editor @@}}
set -gx VISUAL {{@@ editor @@}}

# --- [ i ] - Function section ---
