#!/bin/bash

if [[ $# -eq 0 ]]; then
  >&2 echo "Specify theme name (catppuccin|nord)"
    exit 1
fi

if [[ $1 == "catppuccin" ]] then
  cp ./themes/catppuccin.css ./themes/current.css
elif [[ $1 == "gruvbox" ]] then
  cp ./themes/gruvbox.css ./themes/current.css
fi

killall waybar
sleep 0.5
waybar -l off &
exit 0
