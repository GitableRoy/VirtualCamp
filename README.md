# VBoot

## Contents
1. [About] (#about)
2. Prerequisites
3. [Usage] (#usage)
4. [Sources] (#sources)

## About
This is a script that automates the process that allows your BootCamp to be run through VirtualBox on macOS.  So far, I have only tested this with Windows 10.

## Prerequisites
There are a few things needed before using this script.
* BootCamp with Windows already set up
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed onto your Mac (latest version 5.1.22 when first tested)

## Usage
There are a few things
* Setup.sh:   creates a VM and connects your BootCamp partition to it   
* Clean.sh:   removes your VM and destroys all subsequent files/folders made. Undoes any changes to permissions. Leaves your BootCamp intact
* VBoot.dmg:  an optional application that shortcuts your VM in your Launchpad/Dock

## Sources
Here are some useful links that helped me create this script.  If the script is not working for you, you would like to contribute to the script, or you just want to do the task manually, check these out!
(Daniel Phillips' Notes on VirtualBox BootCamp Connection)[https://danielphil.github.io/windows/virtualbox/osx/2015/08/25/virtualbox-boot-camp.html]
(Jonathan Perkin's Notes on VirtualBox Commands)[https://www.perkin.org.uk/posts/create-virtualbox-vm-from-the-command-line.html]
(VBoxManage Documentation)[https://www.virtualbox.org/manual/ch08.html]
