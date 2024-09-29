# CLEANUP:
[ -f ~/.config/zsh/zenvironment ] && source ~/.config/zsh/zenvironment
# if [[ ! $DISPLAY && $XDG_VTNR -le 2]] then




if [[ "$(tty)" = "/dev/tty1" ]] then
    Hyprland
fi
