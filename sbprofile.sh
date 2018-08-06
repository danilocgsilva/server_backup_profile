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

##
create_profile_folder () {
  if [ ! -f $profile_folder ]
  then
    mkdir -p $profile_folder
  fi
}

##
ask_variables () {
  read -p "Enter the server name: " server_name
  read -p "Enter the user name: " user_name
  read -p "Enter the full pem file path, if any: " full_pem_file_path
  read -p "Enter the server path to your application: " application_server_path
}

##
write_to_file () {
  write_entry_to_profile_path server_name
  write_entry_to_profile_path user_name
  write_entry_to_profile_path full_pem_file_path
  write_entry_to_profile_path application_server_path
}

##
write_entry_to_profile_path () {
  if [ ! -z $1 ]
  then
    echo $1:${!1} >> $full_file_path
  fi
}

##
make_download () {
  echo The file will be downloaded.
}

## Main function
sbprofile () {

  local profile_folder
  local profile_name
  local full_file_path
  local full_pem_file_path
  local server_name
  local user_name
  local application_server_path

  profile_folder=$(return_profile_folder)
  read -p "Type a profile name: " profile_name
  full_file_path=$profile_folder'/'$profile_name
  if [ $(check_if_profile_exists $full_file_path) = 0 ]
  then
    create_profile_folder
    ask_variables
    write_to_file
  fi
  make_download $profile_name
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
