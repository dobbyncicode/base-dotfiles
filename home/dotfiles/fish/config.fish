{%@@ if profile == "localhost" @@%}
starship init fish | source

alias apt="nala"
alias ls="eza --icons --group-directories-first -1"
{%@@ endif @@%}
mise activate fish | source

# --- [ i ] - Abbr section ---
{%@@ if profile == "localhost" @@%}
abbr upup "apt upgrade --asume-yes --full"
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
