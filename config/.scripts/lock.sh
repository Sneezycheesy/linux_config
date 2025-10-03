#!/usr/bin/bash

TEXT='#FFFFFF'
RING='#171a1c'
KEYHL='#104059'
VERIFYING='#0c567b'
WRONG='#3A0000'
INSIDE='#0000008A'
DATEFORMAT="%A, %d %b %Y"
RADIUS=155

playerctl -a pause;
if [ -e "/tmp/mpvsocket" ]; then
echo '{ "command": ["set_property", "pause", true] }' | socat - /tmp/mpvsocket;
fi
# sh ${HOME}/.xmonad/scripts/discord-deafen.sh lock;
pactl set-source-mute @DEFAULT_SOURCE@ 1;
# betterlockscreen --lock;
# use regular i3lock instead
i3lock -B 5 -k --indicator \
                --radius $RADIUS \
                --date-str="${DATEFORMAT}" \
                \
		--time-color=${TEXT} \
                --date-color=${TEXT} \
		--wrong-color=${TEXT} \
		--verif-color=${TEXT} \
		--layout-color=${TEXT} \
                --keyhl-color=${KEYHL} \
                --bshl-color=${WRONG} \
                \
		--ring-color=${RING} \
                --separator-color=${RING} \
                --ringver-color=${VERIFYING} \
		--ringwrong-color=${WRONG} \
                \
		--line-uses-ring \
                \
		--insidever-color=${INSIDE} \
		--insidewrong-color=${INSIDE}
