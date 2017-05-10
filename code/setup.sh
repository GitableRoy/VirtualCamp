#!/bin/bash

BASE=$(dirname $0)
PATH=${1:-$BASE}
VM_NAME="BOOTCAMP" # create naming option
USER=$(id -un)
BOOTCAMP_NUMBER=$(diskutil list disk0 |  grep -a "BOOTCAMP" | cut -c 3-4)
BOOTCAMP_IDENTIFIER=$(diskutil list disk0 |  grep -a "BOOTCAMP" | rev | cut -c 1-7 | rev)
EFI_NUMBER=$(diskutil list disk0 |  grep -a "EFI" | cut -c 3-4)
EFI_IDENTIFIER=$(diskutil list disk0 |  grep -a "EFI" | rev | cut -c 1-7 | rev)

VERSION=$(VBoxManage -v | cut -c 1-6)
VBOXGUEST="VBoxGuestAdditions_"$VERSION".iso"


cd $PATH
mkdir "VirtualBootcamp"
cd "VirtualBootcamp"

# download this machine's VBoxGuestAdditions
curl -C - -O http://download.virtualbox.org/virtualbox/$VERSION/VBoxGuestAdditions_$VERSION.iso

# unmount BOOTCAMP from Volumes
diskutil unmount /Volumes/BOOTCAMP/

# change permissions for EFI
chmod 777 /dev/$EFI_IDENTIFIER

# change permissions for BOOTCAMP
chmod 777 /dev/$BOOTCAMP_IDENTIFIER

# create virtual disk out of BOOTCAMP
VBoxManage internalcommands createrawvmdk -rawdisk /dev/disk0 -filename win10raw.vmdk -partitions $EFI_NUMBER,$BOOTCAMP_NUMBER

# make current user the owner of all vmdk files
chown $USER *.vmdk

# create a fresh VM (assume Windows10)
VBoxManage createvm --name $VM_NAME --ostype "Windows10_64" --register

# VBoxManage storagectl $VM_NAME --name "SATA" --add sata \

# create an IDE Controller (PIIX3) for BOOTCAMP's virtual disk
VBoxManage storagectl $VM_NAME --name "IDE" --add ide --controller "PIIX3"

# attach BOOTCAMP's virtual disk
VBoxManage storageattach $VM_NAME --storagectl "IDE" --port 0 --device 0 --type hdd --medium $PATH/VirtualBootcamp/win10raw.vmdk

# create a SATA Controller (AHCI) for VBoxGuestAdditions disk
VBoxManage storagectl $VM_NAME --name "SATA" --add sata --controller IntelAHCI

# attach VBoxGuestAdditions for
VBoxManage storageattach $VM_NAME --storagectl "SATA" --port 0 --device 0 --type dvddrive --medium $PATH/VirtualBootcamp/$VBOXGUEST
