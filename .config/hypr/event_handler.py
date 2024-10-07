#!/bin/python3

import socket
import os
import sys


def update_waybar():
    os.system("pkill -SIGRTMIN+8 waybar")


socket_path = os.environ.get('XDG_RUNTIME_DIR') + \
        "/hypr/" + os.environ.get('HYPRLAND_INSTANCE_SIGNATURE') + \
        "/.socket2.sock"

if not os.path.exists(socket_path):
    print("could not find socket", file=sys.stderr)
    exit(1)

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)


sock.connect(socket_path)

while True:
    raw_event = sock.recv(4096).decode("utf-8")
    for item in raw_event.split("\n"):
        if item == "":
            continue
        event, data = item.split(">>")
        match event:
            case "monitoradded":
                update_waybar()
            case "focusedmon":
                update_waybar()
            case "openwindow":
                update_waybar()
            case "closewindow":
                update_waybar()
            case "movewindow":
                update_waybar()
            case "workspace":
                update_waybar()
            case "fullscreen":
                update_waybar()
