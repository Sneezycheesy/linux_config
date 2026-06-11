#
# ~/.bashrc
#

#colorscript random

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias yt-dl-mp3='yt-dlp --extract-audio --embed-thumbnail --audio-quality 0 --audio-format mp3 --add-metadata'
alias yt-dl-flac='yt-dlp --extract-audio --audio-quality 0 --audio-format flac --write-thumbnail --add-metadata'
alias stresscpu='openssl speed -multi $(nproc --all)'
alias playmusic='cd ~/ && mp3blaster --playmode="allrandom" -a Music/favourites.m3u'
alias update='yay -Syyu | tee ~/.updates/$(date +"%Y%m%d|%H:%M").log && xmonad --recompile'
alias updates='yay -Qu | wc -l'
alias ssh='TERM="xterm-256color" ssh'
alias udmount='udisksctl mount -b'
alias udunmount='udisksctl unmount -b'
alias handbrake='ghb'
alias screenshot='scrot -so "/tmp/screenshot.png" && cat /tmp/screenshot.png | xclip -selection clipboard -target image/png -i'
alias fooleac='sh /games/star-citizen/SC_EAC_workaround/SC_EAC_workaround.sh'
PS1='[\u@\h \W]\$ '
alias adbmount='aft-mtp-mount'
alias menma="WINEPREFIX=/games/Menmas\ TERA/ wine /games/Menmas\ TERA/drive_c/Program\ Files/MT\ -\ The\ Dream/Menma\'s\ TERA/Menma\'s\ TERA.exe"
alias azura="sh /games/Azura\ TERA/drive_c/Games/Tera/launcher.sh"
alias genpass="passgen | xclip -se c"
alias parentvpn="sudo openvpn --config ~/Documents/pfsense/OpenVPN_Parents_Most_clients.ovpn"

export VISUAL="vim"
export EDITOR="vim"
export LIBVA_DRIVER_NAME="radeonsi"
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK


PATH=${PATH}:/opt/linuxtrack/bin:/home/$USER/.cargo/bin

if [[ "$(tty)" =~ (/dev/tty[\d]?) ]]; then  
    cp ~/.config/chromium/Default/Prefs ~/.config/chromium/Default/Preferences
    startx ~/.xinitrc;
#    sway
fi

if [[ "$(tty)" = "/dev/tty1" || "$(tty)" = "/dev/tty2" ]]; then
	startx ~/.xinitrc;
	#sway
elif [[ "$(tty)" = "/dev/tty3" || "$(tty)" = "/dev/tty4" ]]; then
   startx ~/.xinitrc i3; 
else
    neofetch
fi

wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
# -- START ACTIVESTATE INSTALLATION
export PATH="/home/joshii/.komodoide/12.0/XRE/state/bin:$PATH"
# -- STOP ACTIVESTATE INSTALLATION
# -- START ACTIVESTATE DEFAULT RUNTIME ENVIRONMENT
export PATH="/home/joshii/.cache/activestate/bin:$PATH"
# -- STOP ACTIVESTATE DEFAULT RUNTIME ENVIRONMENT
