#!/bin/sh
# Path to wallpaper folders
WALLPAPERS=~/.config/wallpapers/
cd $WALLPAPERS
selected=$(ls $WALLPAPERS | rofi -dmenu -p "Random Wallpaper Folder: " -theme ./theme.rasi)

echo $selected
