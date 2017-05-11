#!/bin/bash

# Gather neccesary variables
path=$1
vm_name=$2
user=$(id -un)

bootcamp_number=$(diskutil list disk0 |  grep -a "BOOTCAMP" | cut -d ":" -f1 \
 | rev | cut -c 1-2)
bootcamp_identifier=$(diskutil list disk0 |  grep -a "BOOTCAMP" | \
 cut -d ":" -f2 | rev | cut -d " " -f1 | rev)
efi_number=$(diskutil list disk0 |  grep -a "EFI" | cut -d ":" -f1 | \
 rev | cut -c 1-2)
efi_identifier=$(diskutil list disk0 |  grep -a "EFI" | cut -d ":" -f2 | \
 rev | cut -d " " -f1 | rev)

version=$(VBoxManage -v | cut -d "r" -f1)
vboxguest="VBoxGuestAdditions_"$version".iso"


echo "mount BOOTCAMP from Volumes"
diskutil mount $bootcamp_identifier

echo "acquiring Windows OS"
OS=$(/bin/bash ./scripts/getwinos.sh)

mkdir machines
mkdir machines/$vm_name

echo "VBoxGuestAdditions"
/bin/bash ./scripts/getguestadd.sh $vm_name $version

echo "unmount BOOTCAMP from Volumes"
diskutil unmount /Volumes/BOOTCAMP/

echo "change permissions for EFI"
sudo chmod 777 /dev/$efi_identifier

echo "change permissions for BOOTCAMP"
sudo chmod 777 /dev/$bootcamp_identifier

echo "build a VM"
echo $path
/bin/bash ./scripts/createbox.sh \
 $path $user $vboxguest $vm_name $OS $efi_number $bootcamp_number
