D_NAME=
D_DESC=
D_PRIORITY=4096
D_FLAGS=
D_WARNING=

# Paths to replacement files (string or array thereof)
D_DPL_ASSETS=

# Paths to files to be replaced (string or array thereof)
D_TARGETS=

# OS family-specific overrides for $D_TARGETS (narrow defeats broad)
D_TARGETS_LINUX=
D_TARGETS_WSL=
D_TARGETS_BSD=
D_TARGETS_MACOS=

# OS distro-specific overrides for $D_TARGETS (narrow defeats broad)
D_TARGETS_UBUNTU=
D_TARGETS_DEBIAN=
D_TARGETS_FEDORA=

dcheck()    { dln_check;    }
dinstall()  { dln_install;  }
dremove()   { dln_restore;  }