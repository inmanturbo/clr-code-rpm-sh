#!/bin/bash

########## Update VSCODE from rpm on Clear Linux####################

# Check for permissions
# if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

#Check script dependencies
command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed. Please run 'sudo swupd bundle-add jq'. Aborting."; exit 1; }
command -v wget >/dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Please run 'sudo swupd bundle-add wget'.  Aborting."; exit 1; }


# Curl "latest" endpoint to get json object containing 
# info about the latest release then parse it with jq
LATEST_VERSION_INFO=$(curl -sS https://update.code.visualstudio.com/api/update/linux-x64/stable/latest);

# query current version from using VSCode code command
# Note: This will not work if code isn't in the
# system path!
if ! loc="$(type -p "$code")" || [[ -z $loc ]]; then
  
  CURRENT_VERSION=$(code --version | sed -n 2p 2>&1);
  CODE=1
  else
        CURRENT_VERSION="VsCode is not installed on this system.";
        CODE=0
fi

# Query the version info to find the version 
# and the url to download it from
LATEST_VERSION=$(echo $LATEST_VERSION_INFO|jq -r '.version' 2>&1 );
LATEST_VERSION_URL=$(echo $LATEST_VERSION_INFO|jq -r '.url' 2>&1 );

# Check if we are already on the latest version
if [ "${LATEST_VERSION}" = "${CURRENT_VERSION}" ]; then
    echo "Already up to date. Current release is";
    echo $LATEST_VERSION_INFO|jq -r '.productVersion';
    exit 1;
else
    echo "Latest version:" ${LATEST_VERSION};
    echo "Current version:" ${CURRENT_VERSION};
    echo "Do you want to install ${LATEST_VERSION}"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Elevating with sudo! Interrupt now to cancel!"; sleep 2; sudo ./fetch.sh; break;;
        No ) exit;;
    esac
done
fi;
