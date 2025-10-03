#!/usr/bin/bash
#WINEPREFIX=/qvo/world-of-warcraft wine /qvo/world-of-warcraft/drive_c/Program\ Files\ \(x86\)/TradeSkillMaster\ Application/app/TSMApplication.exe

### 
# The premise is simple; 
# When starting Battle.net, the amount of WoW instances is 1. 
# Don't do anything while this is true. 
# When WoW starts, the instances increases to 2. 
# Once this is no longer true, kill the last instance to satisfy Lutris.
### 
while [[ $(pgrep -fc "World of Warcraft") -eq 1 ]]; do 
  echo "Only battle.net runs";
  sleep 5; 
done 

while [[ $(pgrep -fc "World of Warcraft") -gt 1 ]]; do 
  echo "WoW now running too";
  sleep 5; 
done 

pkill -f "World of Warcraft"
