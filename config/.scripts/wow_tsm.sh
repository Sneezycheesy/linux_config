#!/usr/bin/bash
#WINEPREFIX=/qvo/world-of-warcraft wine /qvo/world-of-warcraft/drive_c/Program\ Files\ \(x86\)/TradeSkillMaster\ Application/app/TSMApplication.exe

### 
# The premise is simple; 
# When starting Battle.net, the amount of WoW instances is 1. 
# Don't do anything while this is true. 
# When WoW starts, the instances increases to 2. 
# Once this is no longer true, kill the last instance to satisfy Lutris.
###
while [[ -z $(pgrep WoW.exe) ]]; do
  sleep 5;
done

while [[ $(pgrep WoW.exe) ]]; do
  sleep 5;
done
# closes lutris wrapper for WoW, closing any instance of Battle.net still running 
pkill -f "World of Warcraft"
