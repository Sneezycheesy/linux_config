game_id=`cat ~/.scripts/game_id.txt`

[[ -z ${game_id} ]] && exit
steam steam://launch/${game_id}/VR
