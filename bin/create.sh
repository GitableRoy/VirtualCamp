#!/bin/bash

# Gather neccesary variables
base=$1
dest=$2
vm_name=$3
part_name=$4
efi_toggle=$5
guest_toggle=$6
bit_mode=$7

user=$(id -un)

part_no=$(diskutil list disk0 |  grep -a $part_name | cut -d ":" -f1 \
 | rev | cut -d " " -f1)
part_id=$(diskutil list disk0 |  grep -a $part_name | \
 cut -d ":" -f2 | rev | cut -d " " -f1 | rev)
efi_no=$(diskutil list disk0 |  grep -a "EFI" | cut -d ":" -f1 | \
 rev | cut -d " " -f1)
efi_id=$(diskutil list disk0 |  grep -a "EFI" | cut -d ":" -f2 | \
 rev | cut -d " " -f1 | rev)

version=$(VBoxManage -v | cut -d "r" -f1)
vboxguest="VBoxGuestAdditions_"$version".iso"

# echo "mount BOOTCAMP from Volumes"
diskutil mount $part_id

# echo "acquiring Windows OS"
win_os=$(/bin/bash ./bin/getwinos.sh $part_name $bit_mode)

mkdir $dest/machines
mkdir $dest/machines/$vm_name

if [ $guest_toggle -eq 1 ]; then
  # echo "VBoxGuestAdditions"
  /bin/bash ./bin/getguestadd.sh $dest $vm_name $version
fi

# echo "unmount BOOTCAMP from Volumes"
diskutil unmount /Volumes/$part_name/

# echo "change permissions for EFI"
sudo chmod 777 /dev/$efi_id

# echo "change permissions for BOOTCAMP"
sudo chmod 777 /dev/$part_id

# echo "build a VM"
/bin/bash ./bin/createbox.sh $dest $vm_name $efi_no $part_no \
                             $efi_toggle $guest_toggle $user $vboxguest $win_os

 # echo "build an app for VM"
 /bin/bash ./bin/appbuild.sh $base $dest $vm_name $part_name $efi_id $part_id
