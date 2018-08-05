#!/bin/bash

## version
VERSION="0.0.0"

## Main function
sbprofile () {
  echo Script goes here...
}

## detect if being sourced and
## export if so else execute
## main function with args
if [[ /usr/local/bin/shellutil != /usr/local/bin/shellutil ]]; then
  export -f sbprofile
else
  sbprofile "${@}"
  exit 0
fi
