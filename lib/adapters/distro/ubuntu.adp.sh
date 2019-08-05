#!/usr/bin/env bash
#:title:        Divine.dotfiles Ubuntu adapter
#:author:       Grove Pyree
#:email:        grayarea@protonmail.ch
#:revnumber:    14
#:revdate:      2019.08.05
#:revremark:    Unmute calls to d__os_pkgmgr (except update)
#:created_at:   2019.06.04

## Part of Divine.dotfiles <https://github.com/no-simpler/divine-dotfiles>
#
## An adapter is a set of functions that, when implemented, allow framework to 
#. support Ubuntu OS distribution
#
## For reference, see lib/templates/adapters/distro.adp.sh
#

# Implement detection mechanism for distro
d__adapter_detect_os_distro()
{
  case $D__OS_FAMILY in
    linux|wsl) grep -Fqi ubuntu /etc/os-release && d__os_distro=ubuntu;;
    *) return 1;;
  esac
}

# Implement detection mechanism for package manager
d__adapter_detect_os_pkgmgr()
{
  # Check if apt-get is available
  if apt-get --version &>/dev/null; then

    # Set marker variable
    d__os_pkgmgr='apt-get'

    # Implement wrapper function
    d__os_pkgmgr()
    {
      # Perform action depending on first argument
      case "$1" in
        update)
          dprint_sudo 'Working with apt-get requires sudo password'
          sudo apt-get update -y
          sudo apt-get upgrade -y
          ;;
        check)
          grep -qFx 'install ok installed' \
            <( dpkg-query -W -f='${Status}\n' "$2" 2>/dev/null )
          ;;
        install)
          dprint_sudo 'Working with apt-get requires sudo password'
          sudo apt-get install -y "$2"
          ;;
        remove)
          dprint_sudo 'Working with apt-get requires sudo password'
          sudo apt-get remove -y "$2"
          ;;
        *)  return 1;;
      esac
    }

  fi
}

# Implement overriding mechanism for $D_DPL_TARGET_PATHS and $D_DPL_TARGET_DIR
d__adapter_override_dpl_targets_for_os_distro()
{
  # Check if $D_DPL_TARGET_PATHS_UBUNTU contains at least one string
  if [ ${#D_DPL_TARGET_PATHS_UBUNTU[@]} -gt 1 \
    -o -n "$D_DPL_TARGET_PATHS_UBUNTU" ]; then

    # $D_DPL_TARGET_PATHS_UBUNTU is set: use it instead
    D_DPL_TARGET_PATHS=( "${D_DPL_TARGET_PATHS_UBUNTU[@]}" )
    
  fi

  # Check if $D_DPL_TARGET_DIR_UBUNTU is not empty
  if [ -n "$D_DPL_TARGET_DIR_UBUNTU" ]; then

    # $D_DPL_TARGET_DIR_UBUNTU is set: use it instead
    D_DPL_TARGET_DIR=( "${D_DPL_TARGET_DIR_UBUNTU[@]}" )
    
  fi
}