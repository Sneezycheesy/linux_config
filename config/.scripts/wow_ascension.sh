#!/usr/bin/bash
#WINEPREFIX=/qvo/world-of-warcraft wine /qvo/world-of-warcraft/drive_c/Program\ Files\ \(x86\)/TradeSkillMaster\ Application/app/TSMApplication.exe

### 
# While WoW is not running, do nothing.
### 
while [[ -z $(pgrep -fi "ascension.exe") ]]; do 
  sleep 5; 
done 

# Kill ascension launcher once WoW is running.
pkill -fi "ascension launcher.exe"
