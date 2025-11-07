#!/bin/bash

SOCKET_PATH=$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock

hyprctl activeworkspace -j | jq -r '.id'

exec socat -u UNIX-CONNECT:"$SOCKET_PATH" - | while read -r line; do
  if [[ $line == "workspace>>"* ]]; then
    ws="${line#workspace>>}"
    echo "$ws"
  fi
  if [[ $line == "focusedmon>>"* ]]; then
    ws="${line#focusedmon>>*,}"
    echo "$ws"
  fi
done
