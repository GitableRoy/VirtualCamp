#!/bin/bash

# Gather neccesary variables
dest=$1
vm_name=$2
partition_name=$3
efi_toggle=$4
guest_toggle=$5
base=$6
user=$(id -un)

bootcamp_number=$(diskutil list disk0 |  grep -a "BOOTCAMP" | cut -d ":" -f1 \
 | rev | cut -d " " -f1)
bootcamp_identifier=$(diskutil list disk0 |  grep -a "BOOTCAMP" | \
 cut -d ":" -f2 | rev | cut -d " " -f1 | rev)
efi_number=$(diskutil list disk0 |  grep -a "EFI" | cut -d ":" -f1 | \
 rev | cut -d " " -f1)
efi_identifier=$(diskutil list disk0 |  grep -a "EFI" | cut -d ":" -f2 | \
 rev | cut -d " " -f1 | rev)

version=$(VBoxManage -v | cut -d "r" -f1)
vboxguest="VBoxGuestAdditions_"$version".iso"


# echo "mount BOOTCAMP from Volumes"
diskutil mount $bootcamp_identifier

# echo "acquiring Windows OS"
OS=$(/bin/bash ./scripts/getwinos.sh)

mkdir $dest/machines
mkdir $dest/machines/$vm_name

if [ $guest_toggle -eq 1 ]; then
  echo "VBoxGuestAdditions"
  /bin/bash ./scripts/getguestadd.sh $dest $vm_name $version
fi

# echo "unmount BOOTCAMP from Volumes"
diskutil unmount /Volumes/$partition_name/

# echo "change permissions for EFI"
sudo chmod 777 /dev/$efi_identifier

# echo "change permissions for BOOTCAMP"
sudo chmod 777 /dev/$bootcamp_identifier

# echo "build a VM"
/bin/bash ./scripts/createbox.sh \
 $dest $user $efi_toggle $guest_toggle $vboxguest $vm_name $OS $efi_number $bootcamp_number

 echo "build an app for VM"
 /bin/bash ./scripts/appbuild.sh $dest $vm_name $base
