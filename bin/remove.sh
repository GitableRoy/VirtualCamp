#!/bin/bash

# Commands to destroy VBoxManage
dest=$1
vm_name=$2

echo "Set to remove: "$vm_name
exist=$(VBoxManage list vms | grep $vm_name)
if ! [ -z $exist ]; then
  VBoxManage unregistervm $vm_name --delete
  echo $vm_name" has been removed from "$dest
  rm -rf $dest/machines/$vm_name
  echo $vm_name" folder has been removed from "$dest
  rm -rf $dest/apps/$vm_name.app
  echo $vm_name".app has been removed from "$dest
else
  echo $vm_name" box already doesn't exist, removing subsequent folder"
  rm -rf $dest/machines/$vm_name
  echo $vm_name" folder has been removed"
  rm -rf $dest/apps/$vm_name.app
  echo $vm_name".app has been removed from "$dest
fi
