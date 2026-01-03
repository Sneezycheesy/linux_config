#!/usr/bin/bash
# Manually launch Steam game that uses VR.
# Not all games are happy with OpenXR (WiVRN) starting after the game itself.
# Primary examples: ETS2, ATS.
# Use this script to wait for an active WiVRN connection.
# Then launch Steam, with the game.
function start_steam() {
  game_id=${1,,}
  if [ ! -z `pgrep -x steam` ]; then
    steam_running=TRUE
#    pkill -x steam
    while [ ! -z $(pgrep -x steam) ]; do
      echo "Closing steam..."
      sleep 2
    done
  fi
  
  # Start WiVRN for the OpenXR connection.
  [[ ! -z `pgrep -if envision` ]] && pkill -if envision
  [[ ! -z `pgrep -if wivrn` ]] && pkill -if wivrn
  corectrl & 
  envision --start &

  while [[ -z `pgrep wivrn` ]]; do
    sleep 2
  done
  
  while [[ -z `ss -tun | grep :9757` ]]; do
    echo "No WiVRN connection active"
    # Exit script is wivrn is closed.
    if [[ -z $(pgrep wivrn) ]]; then
      kill_steam
    fi
    sleep 5
  done
  echo "VR connected"
  # Set audio input and output to WiVRN device.
  sh ~/.scripts/volume.sh sink vr wivr;
  sh ~/.scripts/volume.sh source vr wivrn;

  # Give connection some time to settle down.
  # This is a safeguard to prevent games like ETS2.
  # From missing the active connection.
  sleep 2
  
  echo "Starting Steam game"
  setxkbmap us
  steam-native -silent -applaunch ${game_id} &
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
  pkill steam
  pkill envision
  pkill wivrn-server
  setxkbmap us -variant alt-intl
  echo $steam_running
  [[ ! -z $(pgrep lutris-wrapper) ]] && pkill lutris-wrapper 
  [ $steam_running ] && steam -silent
  exit
}

[[ -z $1 ]] && echo "Need an app id" &&  exit
# Look for interrupt signal and kill everything started by script
trap 'echo "Killing everything"; kill_steam;' SIGINT

start_steam $1
