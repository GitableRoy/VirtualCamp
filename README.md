# VirtualCamp

## Contents
1. [About](#about)
2. [Prerequisites](#prerequisites)
3. [Usage](#usage)
4. [Sources](#sources)

## About
This is a script that automates the process that allows your BootCamp to be run through VirtualBox on macOS.  Note: This has only been tested for Windows 10 but it is coded to work for Windows 7, Vista, 8, 8.1, and 10 (64-bit versions only).

## Prerequisites
There are a few things needed before using this script.
* BootCamp with Windows already set up
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed onto your Mac (latest version 5.1.22 when first tested)
* Optional: System Integrity Protection might need to be turned off while setting up (try using script before resorting to this)
  * Start Mac in Recovery Mode
  * Open Terminal under Utilities
  * Enter `csrutil disable`
    * Use `csrutil enable` after set up is complete
  * Restart Mac

## Usage
There are a few things to be used from repository:

```
vcamp - Connect your VirtualBox VM to your macOS Boot Camp

Usage:

  vcamp [commands] [default, options]


Commands:

  create    [-n, -d, -p, -e, -g]    creates a VM for VirtualBox and connects your partition to it
  remove    [-n, -d, -p,]           removes a VM for VirtualBox and destroys all subsequent files/folders made
  restore   [-p]                    restores any changes done to partition permissions        
  -h, --help           


General Command Option:

  default                            Use if your Boot Camp was made with the Boot Camp Assistant application on macOS


Specific Command Options:

    -n, --name    MACHINE_NAME       Decide on a name for the virtual machine you creating/removing       Default=BOOTCAMP  
    -d, --dest    DESTINATION        Decide where you want the necessary files to be created/removed      Default=/path/to/VirtualCamp/machines
    -p, --part    PARTITION_NAME                                                                          Default=BOOTCAMP    
    -g, --guest   ON/OFF                                                                                  Default=ON
    -e, --efi     ON/OFF             ON  if your selected partition was made with Boot Camp Assistant     Default=ON
                                     OFF if your selected partition was made manually


Examples:

  vcamp create default
  vcamp create --name Windows_9 --part Untitled -e OFF -g OFF --dest ~/VirtualBox\ VMs/
  vcamp remove default
  vcamp remove -d ~\Desktop -n boot2
```

## Application
* VirtualCamp.dmg:  an optional application that shortcuts your VM in your Launchpad/Dock

## Set Up
To set up your machine:
1. Open your Terminal
2. Clone the repository in desired location
3. `cd VirtualCamp`
4. `/bin/bash ./vcamp.sh make default`
 * you can select `path` you want your .vmdk and GuestAdditions to be stored
 * you can select the desired `name` for your VM (Note: VirtualCamp.app is set to open a VM named BOOTCAMP, so it won't work if you use another name)

#### Defaults
This will use default script settings.  Open your machines settings to change to desired settings.
* Your VM's name will be `BOOTCAMP` [changeable]
* Your VM's RAM will be 1/4th your actual machines [not-changeable]
* The GuestAdditions for your version of VirtualBox will be added [not currently changable]
* Your VM's video ram will be set to 128 [unchangeable]

### Removing a BootCamp VM
You can always remove a box by:
1. Going through the VirtualBox GUI
2. Deleting the folder that has the .vmdk

The vcamp script can also do this for you in one go:
1. Open your Terminal
2. `cd VirtualCamp`
3. `/bin/bash ./vcamp.sh remove`
  * Use `remove default` if you created your box using defaults
  * Select your VM's `path` or `name` otherwise
    * e.g. `/bin/bash vcamp.sh remove -p ~\Desktop\machines -n boot2`

## Sources
Here are some useful links that helped me create this script.  If the script is not working for you, you would like to contribute to the script, or you just want to do the task manually, check these out!
* [Daniel Phillips' Notes on VirtualBox BootCamp Connection](https://danielphil.github.io/windows/virtualbox/osx/2015/08/25/virtualbox-boot-camp.html)
* [VBoxManage Documentation](https://www.virtualbox.org/manual/ch08.html)
