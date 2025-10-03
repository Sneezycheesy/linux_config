#!/usr/bin/bash
##########################################################################
##########################################################################
# Install packages based on prefered use cases
# Always use Yet Another Yaourt (YaY)
##########################################################################
##########################################################################
trap "echo 'Cleaning up'; cd ..; rm -rf yay; exit" SIGINT
if [[ -z $(command -v yay) ]]; then
  command -v git || sudo pacman -S git
  git clone https://aur.archlinux.org/yay.git
  cd yay
  command -v go || sudo pacman -S go
  makepkg
  sudo pacman -U yay*.pkg.tar.zst
  cd ..
  rm -rf yay
fi

install_packages() {
  #
  # When profiles are requested
  # Only install those
  #
  if [[ ! -z $@ ]]; then
    package_profiles=""
    for profile in $@; do
      package_profiles="${package_profiles} ${profile}"
    done
  else
      package_profiles=$(ls ./packages)
  fi
    
  for package_file in $package_profiles; do
    packages=$(cat ./packages/${package_file})
    yay_packages=""
    for package in $packages; do
      yay_packages="${yay_packages} ${package}"
    done
    yay -S $packages
  done
}

install_packages $@
