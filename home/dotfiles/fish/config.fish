{%@@ if profile == "localhost" @@%}
starship init fish | source

alias apt="nala"
alias ls="eza --icons --group-directories-first -1"
{%@@ endif @@%}

{%@@ if profile != "localhost" @@%}
mise activate fish | source
{%@@ endif @@%}

# --- [ i ] - Abbr section ---
{%@@ if profile == "localhost" @@%}
abbr upup "apt upgrade --asume-yes --full"
{%@@ endif @@%}
{%@@ if profile != "localhost" @@%}
abbr upo "yay -Syyu --noconfirm && poweroff"
abbr upr "yay -Syyu --noconfirm && reboot"
abbr dr "sudo dotdrop install --cfg={{@@ _dotdrop_dotpath.rsplit('/', 1)[0] @@}}/config-root.yaml"
{%@@ endif @@%}

abbr di "dotdrop install --cfg={{@@ _dotdrop_cfgpath @@}}"
abbr du "dotdrop update"
abbr gac --set-cursor "git add . && git commit -m \"%\""
abbr gp "git push -u origin main"
abbr lla "ls -la"
abbr tla "tree -la -I '.git'"

# --- [ i ] - Environment variables section ---
set -gx EDITOR {{@@ editor @@}}
set -gx VISUAL {{@@ editor @@}}
set -gx DOTDROP_MIME_TEXT application/x-wine-extension-ini
# --- [ i ] - Function section ---
