eval (~/.local/bin/eap activate fish | string collect)

if command -v fzf &> /dev/null
    fzf --fish | source
end

abbr ddi "dotdrop install --cfg={{@@ _dotdrop_cfgpath @@}}"
abbr ddu "dotdrop update --cfg={{@@ _dotdrop_cfgpath @@}}"
abbr gac --set-cursor "git add . && git commit -m \"%\""
abbr gp "git push -u origin main"
abbr lla "ls -la"
abbr tla "tree -la -I '.git'"
