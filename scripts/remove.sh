#!/bin/bash

# Commands to destroy VBoxManage
path=$1
vm_name=$2

exist=$(VBoxManage list vms | grep $vm_name)
if ! [ -z $exist ]; then
  VBoxManage unregistervm $vm_name --delete
  echo $vm_name" has been removed"
  rm -rf $path/$vm_name
  echo $vm_name" folder has been removed"
else
  echo $vm_name" box already doesn't exist, removing subsequent folder"
  rm -rf $path/$vm_name
  echo $vm_name" folder has been removed"
fi
