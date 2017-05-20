#!/bin/bash

# build an app for newly created machine

dest=$1
vm_name=$2
base=$3

mkdir $dest/apps

# echo creating app for vm
osacompile -o $dest/apps/$vm_name.app -e "do shell script \"
   checkIfOff=\$(/usr/local/bin/VboxManage showvminfo $vm_name | grep -c 'running (since')
   if [ \$checkIfOff = 0 ]; then
  		/usr/local/bin/VboxManage startvm $vm_name
  		else continue
  	fi
  \""

# echo attaching icon
cp $base/applet.icns $dest/apps/$vm_name.app/Contents/Resources/
