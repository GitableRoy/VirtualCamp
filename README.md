# VirtualCamp

## Contents
1. [About](#about)
2. [Prerequisites](#prerequisites)
3. [Usage](#usage)
4. [Additional Information](#additional-information)
5. [Sources](#sources)

## About
This is a script that automates the process that allows your BootCamp to be run through VirtualBox on macOS.  Note: This has only been tested for Windows 10 but it is coded to work for Windows 7, Vista, 8, 8.1, and 10 (64-bit versions only).

## Prerequisites
There are a few things needed before using this script.
* BootCamp with Windows already set up
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed onto your Mac (version 5.1.22 used with this script)
* Optional: Oracle VM VirtualBox Extension Pack may also need to be installed
* Optional: System Integrity Protection might need to be turned off while setting up (try using script before resorting to this)
  * Start Mac in Recovery Mode
  * Open Terminal under Utilities
  * Enter `csrutil disable`
    * Use `csrutil enable` after set up is complete
  * Restart Mac

## Usage
```
vcamp - Connect your VirtualBox VM to your macOS Boot Camp

usage:

  vcamp [commands] [ default | options ]


Commands:

  create    default | [-n, -d, -p, -e, -g]    creates a VM for VirtualBox and connects your partition to it
  remove    default | [-n, -d, -p,]           removes a VM for VirtualBox and destroys all subsequent files/folders made
  restore   [-p]                              restores any changes done to partition permissions


General Command Option:

  default                            Use if your Boot Camp was made with the Boot Camp Assistant application on macOS


Specific Command Options:

                                                                                                          DEFAULTS
                                                                                                          --------
    -n, --name    MACHINE_NAME       Select a name for the virtual machine you creating/removing          BOOTCAMP
    -d, --dest    DESTINATION        Select where you want the necessary files to be created/removed      /path/to/VirtualCamp
    -p, --part    PARTITION_NAME     Select the partition that holds Windows                              BOOTCAMP
    -g, --guest                      Enable to download and attach compatible VBoxGuestAdditions          Disabled
    -e, --efi                        Enable if your partition was made with Boot Camp Assistant           Disabled


Examples:

  vcamp create default
  vcamp create --name Windows10 --part Untitled -e -g --dest ~/VirtualBox\ VMs/
  vcamp remove default
  vcamp remove -d ~\Desktop -n boot2
```


### Creating a Boot Camp VM
To set up your machine:
1. Open your Terminal
2. Clone the repository in desired location
3. `cd VirtualCamp`
4. `/bin/bash ./vcamp.sh create default`
 * you can select `path` you want your .vmdk and GuestAdditions to be stored
 * you can select the desired `name` for your VM (Note: VirtualCamp.app is set to open a VM named BOOTCAMP, so it won't work if you use another name)

### Removing a Boot Camp VM
The vcamp script can do this for you in one go:
1. Open your Terminal
2. `cd VirtualCamp`
3. `/bin/bash ./vcamp.sh remove`
  * Use `remove default` if you created your box using defaults
  * Select your VM's `path` or `name` otherwise
    * e.g. `/bin/bash vcamp.sh remove -p ~\Desktop\machines -n boot2`

You can always remove a box by:
  1. Going through the VirtualBox GUI
  2. Deleting the folder that has the machine's .vmdk


## Additional Information

### Defaults
This script uses some default settings.  Open your machines settings in VirtualBox to change to desired settings.
* Your VM's RAM will be 1/4th your actual machines
* Your VM's video ram will be set to 128
* Your VM's name will be `BOOTCAMP` if `--name` not used
* The GuestAdditions for your version of VirtualBox will be added:
  - If you use `create default`
  - If you use `create -g`
  - Install on Windows by going to D:/ through the Boot Camp VM


### Machines
Your VM's essential files can be found under a `machines` folder in the VirtualCamp directory or your selected directory.

### Applications
An application is built upon creating a BootCamp VM. It can be found under `apps` folder. Its purpose is to directly open your BootCamp VM without the need of VirtualBox. The app can be dragged into your Applications.
- You can use keep the app in this folder for `vcamp remove` to handle it
- You can update the icon to whatever you please by right clicking and selecting "Get Info"

### Tab Completion
There are tab completion features for vcamp.sh. To use go to Terminal and:
1. `cd /path/to/VirtualCamp`
2. `chmod +x tab-complete.sh`
3. `source tab-complete.sh`

## Known Issues
#### EFI toggle
If you get the UEFI Interactive Shell upon booting your VM, you must change toggle on/off your EFI. You can do this by:
1. Opening VirtualBox.app
2. Enter your VM's settings
3. Go to System tab
4. Under Motherboard, click "Enable EFI"
5. Exit settings and reboot your VM

#### Dev permissions
Permissions are restored to partitions 640 instead of 777 when restarting computer.  This issue has only occurred with a manually partitioned Windows and not for Boot Camp Assistant created Windows.  Fix this by either:
- Rerunning `vcamp create` with the exact sub options as before
- Manually changing permissions in Terminal
  - Use `diskutil list` to find EFI and YOUR_PARTITION's identifiers
  - `chmod 777 /dev/EFI_IDENTIFIER`
  - `chmod 777 /dev/YOUR_PARTITION_IDENTIFIER`

## Sources
Here are some useful links that helped me create this script.  If the script is not working for you, you would like to contribute to the script, or you just want to do the task manually, check these out!
1. [Daniel Phillips' Notes on VirtualBox BootCamp Connection](https://danielphil.github.io/windows/virtualbox/osx/2015/08/25/virtualbox-boot-camp.html)
2. [VBoxManage Documentation](https://www.virtualbox.org/manual/ch08.html)
