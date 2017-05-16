#!/bin/bash

path=$1
user=$2
vboxguest=$3
vm_name=$4
win_os=$5
efi_number=$6
bootcamp_number=$7

memory_size=$(/bin/bash ./scripts/getmacmem.sh)
CPUS=$(/bin/bash ./scripts/getmaccpu.sh)

{
  echo "create virtual disk out of BOOTCAMP"
  sudo -u root VBoxManage internalcommands createrawvmdk -rawdisk /dev/disk0 -filename $path/$vm_name/$win_os.vmdk -partitions $efi_number,$bootcamp_number

  echo "make current user the owner of all vmdk files"
  sudo -u root chown $user machines/$vm_name/*.vmdk

  echo "create a fresh VM"
  VBoxManage createvm --name $vm_name --ostype $win_os --register

  echo "create an IDE Controller (PIIX3) for BOOTCAMP's virtual disk"
  VBoxManage storagectl $vm_name --name "IDE" --add ide --controller "PIIX3"

  echo "attach BOOTCAMP's virtual disk"
  VBoxManage storageattach $vm_name --storagectl "IDE" --port 0 --device 0 --type hdd --medium $path/$vm_name/$win_os.vmdk

  echo "create a SATA Controller (AHCI) for VBoxGuestAdditions disk"
  VBoxManage storagectl $vm_name --name "SATA" --add sata --controller IntelAHCI

  echo "attach VBoxGuestAdditions for"
  VBoxManage storageattach $vm_name --storagectl "SATA" --port 0 --device 0 --type dvddrive --medium $path/$vm_name/$vboxguest

  echo "set VM's ram"
  VBoxManage modifyvm $vm_name --memory $memory_size

  echo "set VM's cpu"
  VBoxManage modifyvm $vm_name --cpus $CPUS

  echo "set VM's vram"
  VBoxManage modifyvm $vm_name --vram 128

  echo "enable EFI for VM"
  VBoxManage modifyvm $vm_name --firmware efi
} ||
{
  echo "Incomplete! There was an error"
  exit 0
}
