#!/bin/bash

########## Update VSCODE from rpm on Clear Linux ####################

# Check for permissions
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

#Check script dependencies
command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed.  Aborting."; exit 1; }
command -v cat >/dev/null 2>&1 || { echo >&2 "I require cat but it's not installed.  Aborting."; exit 1; }
command -v sed >/dev/null 2>&1 || { echo >&2 "I require sed but it's not installed.  Aborting."; exit 1; }
command -v rpm >/dev/null 2>&1 || { echo >&2 "I require rpm but it's not installed.  Aborting."; exit 1; }
command -v wget >/dev/null 2>&1 || { echo >&2 "I require wget but it's not installed.  Aborting."; exit 1; }
command -v tee >/dev/null 2>&1 || { echo >&2 "I require tee but it's not installed.  Aborting."; exit 1; }

# Curl "latest" endpoint to get json object containing 
# info about the latest release then parse it with jq
LATEST_VERSION_URL=$(curl -sS https://update.code.visualstudio.com/api/update/linux-rpm-x64/stable/latest| jq -r '.url');

# query current version with rpm
CURRENT_VERSION=$(rpm -q code);

# Grab the segment of the url to find the version
LATEST_VERSION=${LATEST_VERSION_URL##*/};

if [ "${LATEST_VERSION}" = "${CURRENT_VERSION}.rpm" ]; then
    echo "Already up to date";
    exit 1;
else
    echo "Latest version:" ${LATEST_VERSION};
    echo "Current version:" ${CURRENT_VERSION};
fi;
echo "Downloading . . ."

wget -c ${LATEST_VERSION_URL} -O code-stable-latest.rpm;

rpm -Uvh --nodeps code-stable-latest.rpm;

command -v code >/dev/null 2>&1 || { echo >&2 "Installation failed."; exit 1; }

echo "Success. Rpm packages can be removed with 'rpm -e [release]'";

echo "do you want to configure swupd to whitelist this package?"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo ./whitelist.sh; break;;
        No ) exit;;
    esac
done

