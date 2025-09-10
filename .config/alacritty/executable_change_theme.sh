#!/bin/bash

if [[ $# -eq 0 ]]; then
  >&2 echo "Specify theme name (catppuccin|nord)"
    exit 1
fi

if [[ $1 == "catppuccin" ]] then
  cp ./catppuccin.toml ./CURRENT_THEME.toml
elif [[ $1 == "nord" ]] then
  cp ./nord.toml ./CURRENT_THEME.toml
elif [[ $1 == "gruvbox" ]] then
  cp ./gruvbox.toml ./CURRENT_THEME.toml
fi

touch ./alacritty.toml
