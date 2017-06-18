# Tab completion for vcamp.h

_vcamp_tab_complete ()
{
  local curr prev

  COMPREPLY=()
  curr=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}

  case "$curr" in
    *)
      local opts="create remove restore"
      COMPREPLY=( $( compgen -W "${opts}" ${curr} ) )
      ;;
  esac

  case "$prev" in
    create)
      # case $curr in
      #   *)
          local subopts="default -n -d -p -e -g -b -i \
                         --name --dest --part --efi --guest --bit32 --icns"
          COMPREPLY=( $( compgen -W "${subopts}" -- ${curr} ) )
          ;;
      # esac
      # ;;

   remove)
     case $curr in
       *)
         local subopts="default -n -d -p --name --dest --part"
         COMPREPLY=( $( compgen -W "${subopts}" -- ${curr} ) )
         ;;
     esac
     ;;
   restore)
     case $curr in
       *)
         local subopts="-p --part"
         COMPREPLY=( $( compgen -W "${subopts}"  -- ${curr} ) )
         ;;
     esac
     ;;
    -d|--dest|-p|--part)
      COMPREPLY=( $(compgen -A directory))
      return 0
      ;;
    default|-e|--efi|-g|--guest|-n|--name)
      COMPREPLY=()
      return 0
      ;;
  esac

  return 0
}

complete -F _vcamp_tab_complete -o filenames ./vcamp.sh
