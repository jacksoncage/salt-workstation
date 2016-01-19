#!/bin/bash -x

# sync.sh
#   This script sync files fomr my user and settings back to salt for being added to git

USERNAME=$(find /home/* -maxdepth 0 -print "%f" -type d)


