#!/usr/bin/bash
# Launches WiVRN for OpenXR VR games.
# Sets the desired audio out- and input device.
# Adds a watchdog to stop the VR connection when game exits.

function start_steam() {
  game_id=${1,,}
  # export environment variable to use on wivrn script once Wivrn connects to a client.
  echo ${game_id} > ~/.scripts/game_id.txt
  corectrl & 
  wivrn-dashboard &

  # Set audio input and output to WiVRN device.
  sh ~/.scripts/volume.sh sink speakers;
  sh ~/.scripts/volume.sh source vr wivrn;
  
  setxkbmap us
  wait_for_game_exit

}

###
# Check for running games and keep script alive.
#
# @return void
###
function wait_for_game_exit() {
  # Waits until steam is no longer running any games, then closes it.
  # Waits for steam before checking for a game to be running.
  while [ -z $(pgrep -x steam) ]; do
    echo "Steam not running yet"
    sleep 5
  done
  # While a game isn't running yet, do nothing.
  while [ -z $(pgrep -x reaper) ]; do
    echo "Game not running yet"
    sleep 10
  done
  # Once the game is running, wait for it to close.
  while [ ! -z $(pgrep -x reaper) ]; do
    echo "Game now running"
    sleep 5 
  done

  kill_steam
}

###
# Kill all packages launched by this script.
#
# @return void
###
function kill_steam() {
  # Close everything once the game is done.
  #pkill reaper
  echo $game_id
  [[ ! -z `pgrep -f boxflat` ]] && pkill -f boxflat 
  pkill wivrn-server &&
  pkill wivrn-dashboard &&
  setxkbmap us -variant alt-intl &&
  echo $steam_running
  [[ ! -z $(pgrep lutris-wrapper) ]] && pkill lutris-wrapper 
#  [ $steam_running ] && steam -silent
  sh ~/.scripts/volume.sh sink headset
  rm ~/.scripts/game_id.txt
  exit
}

[[ -z $1 ]] && echo "Need an app id" &&  exit
# Look for interrupt signal and kill everything started by script
trap 'echo "Killing everything"; kill_steam;' SIGINT

start_steam $1
