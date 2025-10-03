#!/usr/bin/bash
##################################################################################
##################################################################################
# Move all config files in this repo to the home folder to sync up the config.
##################################################################################
##################################################################################
CONFIGS=$(ls -a ./config)

if [[ -z $(command rsync) ]]; then
  yay -Syy && yay -S rsync
fi

for config in $CONFIGS; do
  rsync -rP ./config/${config} ~/ 
done
