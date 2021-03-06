#!/usr/bin/env bash
#:title:        Divine Bash procedure: prep-pkgmgr
#:author:       Grove Pyree
#:email:        grayarea@protonmail.ch
#:revdate:      2019.11.30
#:revremark:    Rewrite all Github references to point to new repo location
#:created_at:   2019.10.17

## Part of Divine.dotfiles <https://github.com/divine-dotfiles/divine-dotfiles>
#
## This file is intended to be sourced from framework's main script.
#
## Updates all installed system packages, if package manager is detected.
#

# Marker and dependencies
readonly D__PCD_PREP_PKGMGR=loaded
d__load util workflow
d__load procedure detect-os

# Driver function
d__pcd_prep_pkgmgr()
{
  # Cut-off check
  if [ -z "$D__OS_PKGMGR" ]; then
    d__notify -lx -- 'Skipping updating packages' \
      '(package manager not supported)'
    return 1
  fi

  # Announce
  d__notify -l! -- "Updating system packages via '$D__OS_PKGMGR'"

  # Launch OS package manager
  d__os_pkgmgr update

  # Check return status
  if [ $? -eq 0 ]; then
    d__notify -lv -- "Updated system packages via '$D__OS_PKGMGR'"
    return 0
  else
    d__notify -l! -- "System package manager '$D__OS_PKGMGR'" \
      'returned an error code while updating packages' \
      -n- 'This may or may not be problematic'
    return 1
  fi
}

d__pcd_prep_pkgmgr