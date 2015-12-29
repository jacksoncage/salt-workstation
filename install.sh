#!/bin/bash

# Shell out for the entire install
(
  # Installing base salt system
  curl -L https://bootstrap.saltstack.com -o install_salt.sh
  sh install_salt.sh
)

# Be sure to run local
echo "master: localhost \
file_client: local" > /etc/salt/minion

# Run a highstate
salt-call state.highstate --local --retcode-passthrough --file-root=$(pwd)/state --pillar-root=$(pwd)/pillar -l debug
