if [ ! -z `pgrep stalonetray` ]; then 
  pkill stalonetray ;
else 
  stalonetray --geometry 5x1-700+0 --slot-size 40 --background "#0c1628" &
  nm-applet & 
  blueman-applet & 
fi
