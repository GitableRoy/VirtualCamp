#!/bin/bash

# this script gets the VBoxGuestAdditions right for your VM

dest=$1
vm_name=$2
version=$3

echo "download this machine's VBoxGuestAdditions"
curl -o $dest/machines/$vm_name/VBoxGuestAdditions_$version.iso -C - -O \
 http://download.virtualbox.org/virtualbox/$version/VBoxGuestAdditions_$version.iso

echo "Using SHA256SUMS to check legitimacy"
sum=$(shasum -a 256 $dest/machines/$vm_name/VBoxGuestAdditions_$version.iso | cut -d " " -f1)

check=$(curl http://download.virtualbox.org/virtualbox/$version/SHA256SUMS | grep $sum | cut -d " " -f1)
if ! [ -z $check ]; then
  echo "Safe GuestAdditions downloaded"
else
  echo "Unsafe GuestAdditions downloaded"
  rm $dest/machines/$vm_name/VBoxGuestAdditions_$version.iso
fi
