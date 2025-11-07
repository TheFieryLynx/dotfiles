alias ls="eza"
alias ll="eza -l"
alias lla="ll -a"
alias cd="z"
alias vim="nvim"

alias DOTFILES="cd ~/.dotfiles/"

alias vpn_connect='cat /etc/openvpn/moncloud/login.conf - | openvpn3 session-start --config ~/development/vpn/moncloud.ovpn'
alias vpn_disconnect='openvpn3 session-manage --disconnect --config ~/development/vpn/moncloud.ovpn'
alias vpn_list='openvpn3 sessions-list'
alias vpn_status='openvpn3 session-stats --config moncloud'
