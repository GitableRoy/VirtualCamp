#!/bin/bash

base=$(dirname $0)
path=$base"/machines"
vm_name="BOOTCAMP"
guest="true"

create=0
remove=0
restore=0
valid=0

if [ $# -eq 0 ]; then
  echo ""
  echo "Missing command (\"vcamp --help\" for help)"
  echo ""
  exit 0
else
  case $1 in
    -h|--help)
      valid=1
      echo ""
      echo "usage: "
      echo -e "\t create \t [default | --options] \t Create a BootCamp box with this option"
      echo -e "\t remove \t [default | --options] \t Remove a BootCamp box with this option "
      echo -e "\t restore \t \t \t Restore BootCamp default permissions "
      echo ""
    ;;
    create)
      create=1
      # check if there is an  2 argument
      if [ -z $2 ]; then
        echo ""
        echo "create:"
        echo -e "\t create\t default \t\t runs default options"
        echo ""
        echo -e "\t create\t [-n|--name <string>] \t give your VM a name \t default name is 'BOOTCAMP"
        echo -e "\t create\t [-p|--path=<path>] \t set a path for vdmk \t default is in VirtualCamp/machines/"
        echo -e "\t create\t [-g|--guest <bool>] \t use'Guest Additions' \t default: true"
        exit 0
      elif [[ $2 = "default" ]]; then
        /bin/bash ./scripts/create.sh $path $vm_name
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
                valid=1
                name=$2
              fi
              shift
             ;;
           -p|--path)
            valid=1
            if [ -z $2 ]; then
              echo "Please provide desired path"
              exit 0
            else
              valid=1
              path=$2
            fi
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
        echo -e "\tremove\t [-p|--path=<path>] \t set a path for vdmk \t\t default is in VirtualCamp/machines/"
        exit 0
      elif [[ $2 = "default" ]]; then
        /bin/bash ./scripts/remove.sh $path $vm_name
        exit 0
      else
        while [[ $# -gt 0 ]]
        do
          key="$1"
          case $key in
            -n|--name)
              if [ -z $2 ]; then
                echo "Please provide name of VM to erase"
                exit 0
              else
                valid=1
                name=$2
              fi
              shift
             ;;
           -p|--path)
             if [ -z $2 ]; then
               echo "Please provide path of VM to erase, default search path ./machines/"
               exit 0
             else
               valid=1
               path=$2
             fi
             shift
            ;;
           esac
           shift
         done
      fi
      ;;
    restore)
      echo "Restoring BOOTCAMP permissions"
      /bin/bash ./scripts/restore.sh
      exit 0
      ;;

  esac
fi

if [ $valid -gt 0 ]; then

  if [ $create -gt 0 ]; then
    /bin/bash ./scripts/create.sh $path $vm_name
  fi

  if [ $remove -gt 0 ]; then
    /bin/bash ./scripts/remove.sh $path $vm_name
  fi
else
  echo ""
  echo "Invalid use of vcamp"
  echo ""
  echo "usage: "
  echo -e "\t create \t Create a BootCamp box with this option"
  echo -e "\t remove \t Remove a BootCamp box with this option"
  echo ""
  exit 0
fi
