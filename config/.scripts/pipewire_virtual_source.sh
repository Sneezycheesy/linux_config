#!/usr/bin/bash
until pgrep wireplumber; do sleep 1; done && pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=virtual_source channel_map=front-left,front-right && 
until pgrep wireplumber; do sleep 1; done && sleep 1 && pw-link alsa_input.usb-Focusrite_Scarlett_Solo_4th_Gen_S1731UX360FDF9-00.analog-surround-40:capture_FL virtual_source:input_FL
until pgrep wireplumber; do sleep 1; done && sleep 1 && pw-link alsa_input.usb-Focusrite_Scarlett_Solo_4th_Gen_S1731UX360FDF9-00.analog-surround-40:capture_FR virtual_source:input_FR
