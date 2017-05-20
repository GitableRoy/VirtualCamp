#!/bin/bash

dest=$1
user=$2
efi_toggle=$3
guest_toggle=$4
vboxguest=$5
vm_name=$6
win_os=$7
efi_number=$8
bootcamp_number=$9

memory_size=$(/bin/bash ./scripts/getmacmem.sh)
CPUS=$(/bin/bash ./scripts/getmaccpu.sh)

{
  # echo "create virtual disk out of BOOTCAMP"
  sudo -u root VBoxManage internalcommands createrawvmdk -rawdisk /dev/disk0 -filename $dest/machines/$vm_name/$win_os.vmdk -partitions $efi_number,$bootcamp_number

  # echo "make current user the owner of all vmdk files"
  sudo -u root chown $user $dest/machines/$vm_name/*.vmdk

  # echo "create a fresh VM"
  VBoxManage createvm --name $vm_name --ostype $win_os --register

  # echo "create an IDE Controller (PIIX3) for BOOTCAMP's virtual disk"
  VBoxManage storagectl $vm_name --name "IDE" --add ide --controller "PIIX3"

  # echo "attach BOOTCAMP's virtual disk"
  VBoxManage storageattach $vm_name --storagectl "IDE" --port 0 --device 0 --type hdd --medium $dest/machines/$vm_name/$win_os.vmdk

  # echo "create a SATA Controller (AHCI) for VBoxGuestAdditions disk"
  VBoxManage storagectl $vm_name --name "SATA" --add sata --controller IntelAHCI

  if [ $guest_toggle -eq 1 ]; then
    echo "attach VBoxGuestAdditions for"
    VBoxManage storageattach $vm_name --storagectl "SATA" --port 0 --device 0 --type dvddrive --medium $dest/machines/$vm_name/$vboxguest
  fi

  # echo "set VM's ram"
  VBoxManage modifyvm $vm_name --memory $memory_size

  # echo "set VM's cpu"
  VBoxManage modifyvm $vm_name --cpus $CPUS

  # echo "set VM's vram"
  VBoxManage modifyvm $vm_name --vram 128

  if [[ $efi_toggle -eq 1 ]]; then
    # echo "enable EFI for VM"
    VBoxManage modifyvm $vm_name --firmware efi
  fi
} ||
{
  # echo "Incomplete! There was an error"
  exit 0
}
