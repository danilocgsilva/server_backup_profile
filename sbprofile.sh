#!/bin/bash

## version
VERSION="1.0.1"

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
  read -p "Enter the server address: " server_address
  read -p "Enter the user name: " user_name
  read -p "Enter the full pem file path, if any: " full_pem_file_path
  read -p "Enter the server path to your application: " application_server_path
  read -p "Enter the path to download the files: " local_path_download
  if [ ! -d $local_path_download ]
  then
    echo The provided local path to download does not exists. Aborting.
    exit
  fi
}

##
write_to_file () {
  write_entry_to_profile_path server_address
  write_entry_to_profile_path user_name
  write_entry_to_profile_path full_pem_file_path
  write_entry_to_profile_path application_server_path
  write_entry_to_profile_path local_path_download
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
  load_variables_from_file
  full_local_backup_path=$local_path_download'/'$(date +%Y%m%d-%Hh%Mm%Ss)
  full_local_backup_path_tmp=$full_local_backup_path'-downloading...'
  mkdir $full_local_backup_path_tmp
  scp $(select_pem_path_parameter) -rv $user_name@$server_address:/$application_server_path $full_local_backup_path_tmp
  mv $full_local_backup_path_tmp $full_local_backup_path
}

##
load_variables_from_file () {
  server_address=$(load_entry_from_file server_address)
  user_name=$(load_entry_from_file user_name)
  full_pem_file_path=$(load_entry_from_file full_pem_file_path)
  application_server_path=$(load_entry_from_file application_server_path)
  local_path_download=$(load_entry_from_file local_path_download)
}

##
load_entry_from_file () {
  sed -n /^$1/p $full_file_path | cut -f2 -d:
}

##
select_pem_path_parameter () {
  if [ ! -z $full_pem_file_path ]
  then
    echo -i $full_pem_file_path
  fi
}

## Main function
sbprofile () {

  local profile_folder
  local profile_name
  local full_file_path
  local full_pem_file_path
  local server_address
  local user_name
  local application_server_path
  local local_path_download

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
