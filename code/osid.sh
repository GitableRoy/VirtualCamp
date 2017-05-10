#!/bin/bash

# identifies OS by grep Windows License
W7=$(grep "W7" /Volumes/BOOTCAMP/Windows/System32/License.rtf)
VISTA=$(grep "Vista" /Volumes/BOOTCAMP/Windows/System32/License.rtf)
W8=$(grep "W8" /Volumes/BOOTCAMP/Windows/System32/License.rtf)
W81=$(grep "W8.1" /Volumes/BOOTCAMP/Windows/System32/License.rtf)


# if variable not an empty string then operating system found
if ! [ -z $W7 ]; then
  OS="Windows7_64"
fi

if ! [ -z $Vista ]; then
  OS="WindowsVista_64"
fi

if ! [ -z $W8 ]; then
  OS="Windows8_64"
fi

if ! [ -z $W81 ]; then
  OS="Windows81_64"
fi

if [ -z $OS ]; then
  OS="Windows10_64"
fi

echo $OS
