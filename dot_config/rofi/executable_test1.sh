#!/bin/sh

WallDir=${1:-~/.config/wallpapers/}

rofi -no-config -theme ~/.config/rofi/preview.rasi \
	-show filebrowser -filebrowser-command 'sh /home/andrew/.config/rofi/change.sh' \
	-filebrowser-directory "$WallDir" \
  -selected-row 1

