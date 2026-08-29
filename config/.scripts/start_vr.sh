game_id=`cat ~/.scripts/game_id.txt`

[[ -z ${game_id} ]] && exit
steam steam://launch/${game_id}/VR

# Set audio input and output to WiVRN device.
sh ~/.scripts/volume.sh sink vr wivrn;
sh ~/.scripts/volume.sh source vr wivrn;
