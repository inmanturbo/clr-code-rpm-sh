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

# Query the version info to find the version 
# and the url to download it from
LATEST_VERSION=$(echo $LATEST_VERSION_INFO|jq -r '.version' 2>&1 );
LATEST_VERSION_URL=$(echo $LATEST_VERSION_INFO|jq -r '.url' 2>&1 );

PREFIX="Downloads/${LATEST_VERSION}";

mkdir -p ${PREFIX};

wget -c --https-only ${LATEST_VERSION_URL} -O "${PREFIX}/code-stable-latest.tar.gz";

exit 0;
