#!/bin/bash

current_dir="$HOME/.config/system_scripts/"

waybar_dir="$HOME/.config/waybar"

gruvbox_name="gruvbox" 
catppuccin_name="catppuccin"
themes=($gruvbox_name $catppuccin_name)
rofi_command="rofi -show-icons -dmenu -theme test.rasi"

# Read current theme
read -r current_theme < selected_theme

# Check that current theme name is valid
check_read=0
for theme in "${themes[@]}"; do
  if [[ "$current_theme" == "$theme" ]]; then
    check_read=1
  fi
done

if [[ "$check_read" != "1" ]]; then
  echo "$current_theme variable is missing from the list";
  exit 1;
fi

# Get index of current theme to highlight it in rofi
for i in "${!themes[@]}"; do
   if [[ "${themes[$i]}" = "$current_theme" ]]; then
       index="${i}";
   fi
done

# Select theme from rofi
selected=$(
    for theme in "${themes[@]}"; do
        echo -en "$theme\0icon\x1f$theme.png\n"
    done | $rofi_command -selected-row "$index"
)

check=0
for theme in "${themes[@]}"; do
  if [[ "$selected" == "$theme" ]]; then
    check=1
  fi
done

if [[ "$check" != "1" ]]; then
  echo "Error in selecting theme!";
  exit 1;
fi

# Change theme if valid
if [[ "$selected" != "$current_theme" ]]; then
  echo "Setting $selected theme..."
  cd $waybar_dir
  ./change_theme.sh $selected
  cd $current_dir
  echo "$selected" > selected_theme
else
  echo "$selected theme already applied"
fi















