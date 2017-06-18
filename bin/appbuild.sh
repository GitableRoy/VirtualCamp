#!/bin/bash

# build an app for newly created machine

base=$1
dest=$2
vm_name=$3
part_name=$4
efi_id=$5
part_id=$6

mkdir $dest/apps

osacompile -o $dest/apps/$vm_name.app -e "
  on checkPermissions()
    -- check that EFI and $part_name's RWX permissions set 777
  	set efi to do shell script \"echo \$(ls -l /dev/$efi_id | grep -)\"
  	set part to do shell script \"echo \$(ls -l /dev/$part_id | grep -)\"

  	if not efi = \"\" then
  		do shell script \"
        /bin/chmod 777 /dev/disk0s1
      \" with administrator privileges
   	end if

   	if not part = \"\" then
   		do shell script \"
        /bin/chmod 777 /dev/disk0s4
      \" with administrator privileges
   	end if
  end checkPermissions

  on checkPartition()
  	-- check if partition is mounted, make sure it is not
  	set mounted to do shell script \"
      echo \$(/usr/sbin/diskutil info $part_name | grep Mounte | cut -d ":" -f2)
    \"
  	if mounted = \"Yes\" then
  		do shell script \"diskutil unmount $part_name\"
  	end if
  end checkPartition

  on startMachine()
  	-- start machine if it is not already running
  	set machineState to do shell script \"
      echo \$(/usr/local/bin/VboxManage showvminfo $vm_name | grep -c 'running')
    \"
  	if machineState = \"0\" then
  		do shell script \"/usr/local/bin/VboxManage startvm $vm_name\"
  	end if
  end startMachine

  checkPermissions()
  checkPartition()
  startMachine()
"

# echo attaching icon
cp $base/applet.icns $dest/apps/$vm_name.app/Contents/Resources/
