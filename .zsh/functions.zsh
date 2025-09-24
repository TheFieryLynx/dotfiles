checkInEnv(){
	if [[ "$(command -v deactivate)" == "deactivate" ]]; then
		return 0
	fi
	return 1
}

pathadd(){
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}
