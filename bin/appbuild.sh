#!/bin/bash

# build an app for newly created machine

base=$1
dest=$2
vm_name=$3
part_name=$4
efi_id=$5
part_id=$6

mkdir $dest/apps

# echo creating app for vm
osacompile -o $dest/apps/$vm_name.app -e "do shell script \"
   sudo chmod 777 /dev/$efi_id
   sudo chmod 777 /dev/$part_id
   part_mount=\$(diskutil info $part_name | grep Mount | rev | cut -c 1-1)
   if [ $part_mount="s" ]; then
     diskutil unmount $part_name
   fi
   vm_on=\$(/usr/local/bin/VboxManage showvminfo $vm_name | grep -c 'running')
   if [ \$vm_on = 0 ]; then
  		/usr/local/bin/VboxManage startvm $vm_name
  		else continue
  	fi
  \""

# echo attaching icon
cp $base/applet.icns $dest/apps/$vm_name.app/Contents/Resources/
