#!/bin/bash -eu

setup_progress "configuring ssh"
auth_keys_file='/root/.ssh/authorized_keys'
sshd_config_file='/etc/ssh/sshd_config'

# If the user has defined a public key for root SSH access apply it
if ! [ -z "${SSH_ROOT_PUBLIC_KEY}" ]
then
  # Don't overwrite the auth_keys_file if it already exists as the user may have modified it further
  if ! [ -s "${auth_keys_file}" ]
  then
    echo "${SSH_ROOT_PUBLIC_KEY}" > "${auth_keys_file}"
  fi
fi

# Disable SSH Password Authentication if the user requested us to do so
if [ "${SSH_DISABLE_PASSWORD_AUTHENTICATION:-false}" = "true" ]
then
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' ${sshd_config_file}
  systemctl reload sshd
fi

setup_progress "done configuring ssh"
