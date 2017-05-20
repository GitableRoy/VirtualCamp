#!/bin/bash

base=$(dirname $0)
dest=$base
vm_name="BOOTCAMP"
part_name="BOOTCAMP"
guest_toggle=0
efi_toggle=0

create=0
remove=0
restore=0
valid=0

if [ $# -eq 0 ]; then
  /bin/bash ./scripts/usage.sh
  exit 0
else
  case $1 in

    create)
      create=1
      # check if there is an  2 argument
      if [ -z $2 ]; then
        echo ""
        echo "create:"
        echo -e "\t create\t default \t\t runs default options"
        echo ""
        echo -e "\t create\t [-n|--name <string>] \t give your VM a name \t default name is 'BOOTCAMP"
        echo -e "\t create\t [-p|--dest=<dest>] \t set a dest for vdmk \t default is in VirtualCamp/machines/"
        echo -e "\t create\t [-g|--guest <bool>] \t use'Guest Additions' \t default: true"
        exit 0
      elif [[ $2 = "default" ]]; then
        /bin/bash ./scripts/create.sh $dest $vm_name $part_name 1 1 # efi and guest on
        exit 0
      else
        while [[ $# -gt 0 ]]
        do
          key="$1"
          case $key in
            -n|--name)
                valid=1
              if [ -z $2 ]; then
                echo "Please provide name for your VM"
                exit 0
              else
                vm_name=$2
              fi
              shift
             ;;
           -d|--dest)
            valid=1
            if [ -z $2 ]; then
              echo "Please provide desired dest"
              exit 0
            else
              valid=1
              dest=$2
            fi
            shift
            ;;
          -e|--efi)
              valid=1
              efi_toggle=1
            shift
           ;;
          -g|--guest)
              valid=1
              guest_toggle=1
            shift
           ;;
          esac
          shift
        done
      fi
      ;;
    remove)
      remove=1
      if [ -z $2 ]; then
        echo ""
        echo "remove:"
        echo -e "\tremove\t default \t\t runs default options"
        echo ""
        echo -e "\tremove\t [-n|--name <string>] \t select your VM to delete \t default VM is 'BOOTCAMP'"
        echo -e "\tremove\t [-p|--dest=<dest>] \t set a dest for vdmk \t\t default is in VirtualCamp/machines/"
        exit 0
      elif [[ $2 = "default" ]]; then
        /bin/bash ./scripts/remove.sh $dest $vm_name $part_name
        exit 0
      else
        while [[ $# -gt 0 ]]
        do
          key="$1"
          case $key in
            -n|--name)
              if [ -z $2 ]; then
                echo "Please provide name of VM to erase | default BOOTCAMP"
                exit 0
              else
                valid=1
                vm_name=$2
              fi
              shift
             ;;
           -d|--dest)
             if [ -z $2 ]; then
               echo "Please provide dest of VM to erase | default search dest ./machines/"
               exit 0
             else
               valid=1
               dest=$2
             fi
             shift
            ;;
           esac
           shift
         done
      fi
      ;;
    restore)
      if [ -z $2 ]; then
        echo ""
        echo "restore:"
        echo -e "\trestore\t default \t\t runs default options"
        echo -e "\trestore\t [-p|--part <string>] \t select the partition you wish to restore\t default partition is 'BOOTCAMP'"
        exit 0
      else
        while [[ $# -gt 0 ]]
        do
          key="$1"
          case $key in
            default)
              echo "Restoring "$part_name" permissions"
              /bin/bash ./scripts/restore.sh $part_name
              shift
            ;;
            -p|--part)
              if [ -z $2 ]; then
                echo "Please enter partition permissions you which to restore"
                exit 0
              else
                part_name=$2
                echo "Restoring "$part_name" permissions"
                /bin/bash ./scripts/restore.sh $part_name
              fi
              shift
             ;;
          esac
          shift
         done
       fi
      exit 0
      ;;

  esac
fi

if [ $valid -gt 0 ]; then

  if [ $create -gt 0 ]; then
    /bin/bash ./scripts/create.sh $dest $vm_name $part_name $efi_toggle $guest_toggle
  fi

  if [ $remove -gt 0 ]; then
    /bin/bash ./scripts/remove.sh $dest $vm_name $part_name
  fi
else
  echo "Invalid usage. Read usage details below"
  /bin/bash ./scripts/usage.sh
  exit 0
fi
