#!/bin/bash

function log_progress () {
  if declare -F setup_progress > /dev/null
  then
    setup_progress "install-user-requested-packages: $1"
    return
  fi
  echo "install-user-requested-packages: $1"
}

log_progress "Installing $INSTALL_USER_REQUESTED_PACKAGES..."
# shellcheck disable=SC2086
DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install $INSTALL_USER_REQUESTED_PACKAGES
