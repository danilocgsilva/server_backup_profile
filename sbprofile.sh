#!/bin/bash

## version
VERSION="0.0.0"

## The base path of all recorded profiles
return_profile_folder () {
  echo ~/.sbprofile
}


## return 1 to true or 0 to false
check_if_profile_exists () {

  profile_file=$1

  if [ -f $profile_file ]
  then
    echo 1
  else
    echo 0
  fi
}

create_profile_file () {

  echo I may create the $profile_folder

  if [ -f $profile_folder ]
  then
    mkdir -p $profile_folder
  fi

  touch $full_file_path

  echo The profile file has been created
}

make_download () {
  echo The file will be downloaded.
}

## Main function
sbprofile () {
  local profile_folder
  local profile_name
  local full_file_path
  profile_folder=$(return_profile_folder)
  read -p "Type a profile name: " profile_name
  full_file_path=$profile_folder'/'$profile_name
  if [ $(check_if_profile_exists $full_file_path) = 1 ]
  then
    make_download
  else
    create_profile_file
  fi
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
