#!/bin/bash
# Waits until steam is no longer running any games, then closes it.

while [ -z $(pgrep -x steam) ]
do
    echo Steam
    sleep 10
done
while [ -z $(pgrep -x reaper) ]
do
    echo "NO reaper"
    sleep 10
done
while [ ! -z $(pgrep -x reaper) ]
do
    echo Reaper
    sleep 10
done
pkill steam &

