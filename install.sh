#!/usr/bin/bash
# Install all required packages that this configuration uses.
# To add or remove packages, update requirements.txt.
# This install script assumes use of an ARCH-based distro with the use of Yet Another Yogurt (yay).

# Make sure yay is installed first.
# The "extra" repository source is needed in Arch.
if [[ -z $(pacman -Qe | grep "yay") ]]; then
    sudo pacman -S --needed git base-devel go
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

if [[ -z $(pacman -Qe | grep "yay") ]]; then
    echo "Yay was not installed correctly, please fix the issue"
    exit
fi

packages=""
for line in $(cat ./requirements.txt); do
    packages="$packages $line"
done
yay -S $packages

if [[ ! -z $(pacman -Qe | grep "xmonad") ]]; do
    xmonad --recompile
fi