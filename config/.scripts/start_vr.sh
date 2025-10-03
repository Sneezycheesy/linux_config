#!/usr/bin/bash
# Start every package required to play VR games
# Does NOT use SteamVR
# Uses Envision with WiVrN
#
if [[ `pgrep -x steam` ]]; then
  pkill steam
fi

while [ ! -z $(pgrep -x steam) ]
do
    sleep 2
done

if [[ $1 == "vr" ]]; then
  pkill wivrn-server

  [[ -z $(ps -u $USER | grep corectrl | grep -v grep) ]] && corectrl &
  disown;
  [[ -z $(ps -u $USER | grep -i wivrn-server | grep -v grep) ]] && envision --start &
  disown;
  sh ~/.scripts/volume.sh sink vr wivr;
  sh ~/.scripts/volume.sh source vr wivrn;
fi

# Waits until steam is no longer running any games, then closes it.

while [ -z $(pgrep -x steam) ]
do
    sleep 10
done
while [ -z $(pgrep -x reaper) ]
do
    sleep 10
done
while [ ! -z $(pgrep -x reaper) ]
do
    sleep 5 
done
pkill steam &
pkill wivrn-server
