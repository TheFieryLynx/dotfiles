#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Please provide a wallpaper file as an argument."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: File not found: $1"
    exit 1
fi

hyprpaper_config_file="$HOME/.config/hypr/hyprpaper/hyprpaper.conf"


sed -i -e "s|^preload = .*$|preload = $1|" \
       -e "s|^wallpaper = .*$|wallpaper = ,$1|" \
       "$hyprpaper_config_file"

killall -e hyprpaper & 
sleep 1; 
hyprpaper -c ~/.config/hypr/hyprpaper/hyprpaper.conf &

echo "Wallpaper settings in hyprpaper.conf updated successfully."
