if [ ! -z `pgrep stalonetray` ]; then 
$(`killall -q stalonetray && killall -q nm-applet`);
else 
$(`nm-applet & stalonetray --geometry 5x1-2500 &`);
fi
