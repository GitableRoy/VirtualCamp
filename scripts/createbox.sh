#!bin/bash

{
  echo "create virtual disk out of BOOTCAMP"
  sudo -u root VBoxManage internalcommands createrawvmdk -rawdisk /dev/disk0 -filename $OS.vmdk -partitions $EFI_NUMBER,$BOOTCAMP_NUMBER

  echo "make current user the owner of all vmdk files"
  sudo -u root chown $USER *.vmdk

  echo "create a fresh VM"
  VBoxManage createvm --name $VM_NAME --ostype $OS --register

  echo "create an IDE Controller (PIIX3) for BOOTCAMP's virtual disk"
  VBoxManage storagectl $VM_NAME --name "IDE" --add ide --controller "PIIX3"

  echo "attach BOOTCAMP's virtual disk"
  VBoxManage storageattach $VM_NAME --storagectl "IDE" --port 0 --device 0 --type hdd --medium $CPATH/VirtualCamp/$OS.vmdk

  echo "create a SATA Controller (AHCI) for VBoxGuestAdditions disk"
  VBoxManage storagectl $VM_NAME --name "SATA" --add sata --controller IntelAHCI

  echo "attach VBoxGuestAdditions for"
  VBoxManage storageattach $VM_NAME --storagectl "SATA" --port 0 --device 0 --type dvddrive --medium $CPATH/VirtualCamp/$VBOXGUEST
} ||
{
  echo "Not working!"
}
