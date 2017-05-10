#!/bin/bash

# Gather neccesary variables
BASE=$(dirname $0)
CPATH=$BASE
VM_NAME="${1:-BOOTCAMP3}" # create naming option
USER=$(id -un)
BOOTCAMP_NUMBER=$(diskutil list disk0 |  grep -a "BOOTCAMP" | cut -c 3-4)
BOOTCAMP_IDENTIFIER=$(diskutil list disk0 |  grep -a "BOOTCAMP" | rev | cut -c 1-7 | rev)
EFI_NUMBER=$(diskutil list disk0 |  grep -a "EFI" | cut -c 3-4)
EFI_IDENTIFIER=$(diskutil list disk0 |  grep -a "EFI" | rev | cut -c 1-7 | rev)
VERSION=$(VBoxManage -v | cut -c 1-6)
VBOXGUEST="VBoxGuestAdditions_"$VERSION".iso"


echo "mount BOOTCAMP from Volumes"
diskutil mount $BOOTCAMP_IDENTIFIER

echo "acquiring windows10 OS"
OS=$(/bin/bash ./scripts/getwinos.sh)


cd $CPATH
mkdir "VirtualCamp"
cd "VirtualCamp"

echo "download this machine's VBoxGuestAdditions"
curl -C - -O http://download.virtualbox.org/virtualbox/$VERSION/VBoxGuestAdditions_$VERSION.iso

echo "unmount BOOTCAMP from Volumes"
diskutil unmount /Volumes/BOOTCAMP/

echo "change permissions for EFI"
chmod 777 /dev/$EFI_IDENTIFIER

echo "change permissions for BOOTCAMP"
chmod 777 /dev/$BOOTCAMP_IDENTIFIER

./scripts/createbox.sh

# {
#   echo "create virtual disk out of BOOTCAMP"
#   sudo -u root VBoxManage internalcommands createrawvmdk -rawdisk /dev/disk0 -filename $OS.vmdk -partitions $EFI_NUMBER,$BOOTCAMP_NUMBER
#
#   echo "make current user the owner of all vmdk files"
#   sudo -u root chown $USER *.vmdk
#
#   echo "create a fresh VM"
#   VBoxManage createvm --name $VM_NAME --ostype $OS --register
#
#   echo "create an IDE Controller (PIIX3) for BOOTCAMP's virtual disk"
#   VBoxManage storagectl $VM_NAME --name "IDE" --add ide --controller "PIIX3"
#
#   echo "attach BOOTCAMP's virtual disk"
#   VBoxManage storageattach $VM_NAME --storagectl "IDE" --port 0 --device 0 --type hdd --medium $CPATH/VirtualCamp/$OS.vmdk
#
#   echo "create a SATA Controller (AHCI) for VBoxGuestAdditions disk"
#   VBoxManage storagectl $VM_NAME --name "SATA" --add sata --controller IntelAHCI
#
#   echo "attach VBoxGuestAdditions for"
#   VBoxManage storageattach $VM_NAME --storagectl "SATA" --port 0 --device 0 --type dvddrive --medium $CPATH/VirtualCamp/$VBOXGUEST
# } ||
# {
#   echo "Done!"
# }
