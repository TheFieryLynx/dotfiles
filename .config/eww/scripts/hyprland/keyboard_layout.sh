#!/bin/bash

SOCKET_PATH=$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock

echo "??"

exec socat -u UNIX-CONNECT:"$SOCKET_PATH" - | while read -r line; do
  if [[ $line == "activelayout>>"* ]]; then
    al="${line#activelayout>>*,}"
    al="$(echo $al | cut -c -2 | tr '[:lower:]' '[:upper:]')"
    echo "$al"
  fi
done
