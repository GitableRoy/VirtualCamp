#!/bin/bash

# build an app for newly created machine

base=$1
dest=$2
vm_name=$3
partition_name=$4
efi_identifier=$5
bootcamp_identifier=$6

mkdir $dest/apps

# echo creating app for vm
osacompile -o $dest/apps/$vm_name.app -e "do shell script \"
   chmod 777 /dev/$efi_identifier
   chmod 777 /dev/$bootcamp_identifier
   part_mount=\$(diskutil info $partition_name | grep Mount | rev | cut -c 1-1)
   if [ $part_mount="s" ]; then
     diskutil unmount $partition_name
   fi
   vm_on=\$(/usr/local/bin/VboxManage showvminfo $vm_name | grep -c 'running')
   if [ \$vm_on = 0 ]; then
  		/usr/local/bin/VboxManage startvm $vm_name
  		else continue
  	fi
  \""

# echo attaching icon
cp $base/applet.icns $dest/apps/$vm_name.app/Contents/Resources/
