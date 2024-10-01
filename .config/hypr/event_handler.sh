#!/usr/bin/env bash

echo "Start event handler for hyprland"
function handle {
#echo "${1}"
    case $1 in
        monitoradded*) echo "monitoradded"; pkill -SIGRTMIN+8 waybar ;;
        focusedmon*)   echo "focusedmon"  ; pkill -SIGRTMIN+8 waybar ;;
        openwindow*)   echo "openwindow"  ; pkill -SIGRTMIN+8 waybar ;;
        closewindow*)  echo "closewindow" ; pkill -SIGRTMIN+8 waybar ;;
        movewindow*)   echo "movewindow"  ; pkill -SIGRTMIN+8 waybar ;;
        workspace*)    echo "workspace"   ; pkill -SIGRTMIN+8 waybar ;;
        fullscreen*)   echo "fullscreen"  ; pkill -SIGRTMIN+8 waybar ;;
#        monitoradded*) echo "monitoradded" ;;
#        focusedmon*)   echo "focusedmon"   ;;
#        openwindow*)   echo "openwindow"   ;;
#        closewindow*)  echo "closewindow"  ;;
#        movewindow*)   echo "movewindow"   ;;
#        workspace*)    echo "workspace"    ;;
#        fullscreen*)   echo "fullscreen"   ;;
    esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
echo "end event handler for hyprland"
