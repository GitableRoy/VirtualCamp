#!/bin/bash

# this script gets the VBoxGuestAdditions right for your VM

vm_name=$1
version=$2

echo "download this machine's VBoxGuestAdditions"
curl -o machines/$vm_name/VBoxGuestAdditions_$version.iso -C - -O \
 http://download.virtualbox.org/virtualbox/$version/VBoxGuestAdditions_$version.iso

echo "Using SHA256SUMS to check legitimacy"
sum=$(shasum -a 256 machines/$vm_name/VBoxGuestAdditions_$version.iso | cut -d " " -f1)
$sum

check=$(curl http://download.virtualbox.org/virtualbox/$version/SHA256SUMS | grep $sum)
if ! [ -z $check ]; then
  echo "Safe GuestAdditions downloaded"
else
  echo "Unsafe GuestAdditions downloaded"
  rm machines/$vm_name/VBoxGuestAdditions_$version.iso
fi
