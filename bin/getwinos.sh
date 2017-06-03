#!/bin/bash

part_name=$1
bit_mode=$2

# identifies OS by grep Windows License
W7=$(     grep  "W7"     /Volumes/"$part_name"/Windows/System32/License.rtf)
VISTA=$(  grep  "Vista"  /Volumes/"$part_name"/Windows/System32/License.rtf)
W8=$(     grep  "W8"     /Volumes/"$part_name"/Windows/System32/License.rtf)
W81=$(    grep  "W8.1"   /Volumes/"$part_name"/Windows/System32/License.rtf)


# if variable not an empty string then operating system found
if ! [ -z $W7 ]; then
  OS="Windows7"
fi

if ! [ -z $Vista ]; then
  OS="WindowsVista"
fi

if ! [ -z $W8 ]; then
  OS="Windows8"
fi

if ! [ -z $W81 ]; then
  OS="Windows81"
fi

if [ -z $OS ]; then
  OS="Windows10"
fi

OS=$OS$bit_mode

echo $OS
