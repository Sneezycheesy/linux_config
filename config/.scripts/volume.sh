#!/usr/bin/bash
if [[ $1 == toggle ]]; then
	if [[ $2 == mpv ]]; then
		echo '{ "command": ["cycle", "mute"] }' | socat - /tmp/mpvsocket;
	else
		source_sink="@DEFAULT_$2@";
		pactl set-$3-mute ${source_sink} toggle;
	fi
fi

if [[ $1 == mpv ]]; then
	if [[ $2 != volume ]]; then
		if [ -e "/tmp/mpvsocket" ]; then
			echo '{ "command": ["cycle", "mute"] }' | socat - /tmp/mpvsocket;
		fi
	else
		if [[ $3 == 1 ]]; then
			echo '{ "command": ["add", "volume", 1] }' | socat - /tmp/mpvsocket;
		else
			echo '{ "command": ["add", "volume", -1] }' | socat - /tmp/mpvsocket;
		fi
	fi
fi

if [[ $1 == volume ]]; then
	pactl set-$2-volume @DEFAULT_$3@ $41%;
	echo "#24" `#24 pactl get-source-volume @DEFAULT_SOURCE@ | grep "Volume" | cut -d"/" -f2 | polybar screen0`;
fi

if [[ $1 == sink ]]; then
	if [[ $2 == speakers ]]; then
		sink=$(pactl list sinks | grep -i "name:" | grep -i "media_electronics" | cut -d" " -f2);
		#port="analog-output-lineout";
	elif [[ $2 == headset ]]; then
		sink=$(pactl list sinks | grep -i "name:" | grep -i "umc204hd" | grep -i "sink" | cut -d" " -f2);
		port="Line A"
	elif [[ $2 == vr ]]; then
		if [[ ! -z $3 ]]; then
		  while [[ -z $sink ]]; do
	            sink=$(pactl list sinks | grep -i "name:" | grep -i $3 | grep -v -i "monitor" | cut -d" " -f2);
		  done
		else
		  sink=$(pactl list sinks | grep -i "name:" | grep -i "wivrn" | cut -d" " -f2);
		  [[ -z $sink ]] && sink=$(pactl list sinks | grep -i "name:" | grep -i "alvr" | cut -d" " -f2);
		fi
	else
		bluetooth=$(pactl list sinks | grep "Name: bluez_*")
		sink=$(cut -d':' -f2 <<< ${bluetooth});
	fi

	# Set default sink to headphones (primarily because vr sink might not be available)
	[[ -z $sink ]] && sink=	$(pactl list sinks | grep -i "name:" | grep -i "Line1" | cut -d" " -f2);
        pactl set-default-sink $sink;

	[[ ! -z $port ]] && pactl set-sink-port $sink $port
	#xmonad --restart;
#	pkill -USR1 polybar
fi

if [[ $1 == source ]]; then
	if [[ $2 == headset ]]; then
		source=$(pactl list sources | grep -i "name:" | grep -i "umc204hd" | grep -i -v "monitor" | cut -d" "  -f2);
	elif [[ $2 == record ]]; then
		source="alsa_input.usb-OmniVision_Technologies__Inc._USB_Camera-B4.09.24.1-01.analog-surround-40";
	elif [[ $2 == vr ]]; then
	  if [[ ! -z $3 ]]; then
            # If always run AFTER connecting to Envision the while loop isn't needed.
            # This will break any app if "use microphone" is disabled on the headset.
            #while [[ -z $source ]]; do
              source=$(pactl list sources | grep -i "name:" | grep -i $3 | grep -i -v "monitor" | cut -d" " -f2);
	    #done
          else
	   source=$(pactl list sources | grep -i "name:" | grep -i "wivrn" | cut -d" "  -f2);
	   [[ -z $source ]] && source=$(pactl list sources | grep -i "name:" | grep -i "alvr" | cut -d" "  -f2);
	  fi
	fi

	
	pactl set-default-source $source;
	#xmonad --restart;
#	pkill -USR1 polybar
fi
