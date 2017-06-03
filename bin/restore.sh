#!/bin/bash

# this script is made to change BOOTCAMP permissions back to normal

part_name=$1

part_id=$(diskutil list disk0 |  grep -a "$part_name" | \
 cut -d ":" -f2 | rev | cut -d " " -f1 | rev)

efi_id=$(diskutil list disk0 |  grep -a "EFI" | cut -d ":" -f2 | \
rev | cut -d " " -f1 | rev)

echo "unmount BOOTCAMP from Volumes"
diskutil unmount /Volumes/$part_name/

echo "change permissions for EFI"
sudo chmod 640 /dev/$efi_id

echo "change permissions for BOOTCAMP"
sudo chmod 640 /dev/$part_id

echo "mount BOOTCAMP from Volumes"
diskutil mount $part_id
