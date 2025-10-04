#!/usr/bin/bash
##########################################################################
##########################################################################
# Install packages based on prefered use cases
# Always use Yet Another Yaourt (YaY)
##########################################################################
##########################################################################
if [[ -z $(command -v yay) ]]; then
  command -v git || sudo pacman -S git
  # Should cloning git take way too long, clean up folder on interupt.
  trap "rm -rf yay; exit" SIGINT
  git clone https://aur.archlinux.org/yay.git

  cd yay
  # Should building with go take way too long, clean up folder in root directory on interrupt.
  trap "echo 'Cleaning up yay folder'; cd ..; rm -rf yay; exit" SIGINT
  command -v go || sudo pacman -S go
  makepkg
  sudo pacman -U yay*.pkg.tar.zst
  cd ..
  rm -rf yay
fi

#
# Install all packages based on profiles.
# Installs all packages listed in packages folder by default.
#
install_packages() {
  #
  # When profiles are requested.
  # Only install those.
  #
  if [[ ! -z $@ ]]; then
    package_profiles=""
    for profile in $@; do
      # Skip for loop when profile does not exist.
      [ -f ./packages/${profile} ] || continue
      package_profiles="${package_profiles} ${profile}"
    done
  else
      package_profiles=$(ls ./packages)
  fi
    
  for package_file in $package_profiles; do
    [ -f ./packages/${package_file} ] || continue
    packages=$(cat ./packages/${package_file})
    yay_packages=""
    for package in $packages; do
      yay_packages="${yay_packages} ${package}"
    done
    yay -S $packages
  done
}

install_packages $@
