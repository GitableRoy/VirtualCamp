# VBoot

## Contents
1. [About](#about)
2. [Prerequisites](#prerequisites)
3. [Usage](#usage)
4. [Sources](#sources)

## About
This is a script that automates the process that allows your BootCamp to be run through VirtualBox on macOS.  So far, I have only tested this with Windows 10 but it is coded to work for Windows 7, Vista, 8, 8.1, and 10 (64-bit versions only).

## Prerequisites
There are a few things needed before using this script.
* BootCamp with Windows already set up
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed onto your Mac (latest version 5.1.22 when first tested)
* System Integrity Protection must be turned off while setting up
  * Start Mac in Recovery Mode
  * Open Terminal under Utilities
  * Enter `csrutil disable`
    * Use `csrutil enable` after set up is complete
  * Restart Mac

## Usage
There are a few things
* Setup.sh:   creates a VM and connects your BootCamp partition to it   
* Clean.sh:   removes your VM and destroys all subsequent files/folders made. Undoes any changes to permissions. Leaves your Boot Camp intact
* VBoot.dmg:  an optional application that shortcuts your VM in your Launchpad/Dock

### Set Up
To set up your box
1. Open your Terminal
2. Clone the repository in desired location
3. `cd Vboot`
4. `sudo /bin/bash ./setup.sh`

This will use default script settings
  * Your VM's RAM will be 1/4th your actual machines
  * Your VM's name will be BOOTCAMP

## Sources
Here are some useful links that helped me create this script.  If the script is not working for you, you would like to contribute to the script, or you just want to do the task manually, check these out!
* (Daniel Phillips' Notes on VirtualBox BootCamp Connection)[https://danielphil.github.io/windows/virtualbox/osx/2015/08/25/virtualbox-boot-camp.html]
* (Jonathan Perkin's Notes on VirtualBox Commands)[https://www.perkin.org.uk/posts/create-virtualbox-vm-from-the-command-line.html]
* (VBoxManage Documentation)[https://www.virtualbox.org/manual/ch08.html]
