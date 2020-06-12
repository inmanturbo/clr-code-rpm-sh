#!/bin/bash

command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed. Please run 'sudo swupd install jq'. Aborting."; exit 1; }
command -v rpm >/dev/null 2>&1 || { echo >&2 "I require rpm but it's not installed. Aborting."; exit 1; }

if ! [[ $(rpm -q code) ]]; then
    echo "VsCode rpm is not installed";
    exit 1
fi
# Curl "latest" endpoint to get json object containing 
# info about the latest release then parse it with jq
LATEST_VERSION_URL=$(curl -sS https://update.code.visualstudio.com/api/update/linux-rpm-x64/stable/latest| jq -r '.url');

# query current version with rpm
CURRENT_VERSION=$(rpm -q code);

# Grab the segment of the url to find the version
LATEST_VERSION=${LATEST_VERSION_URL##*/};

if [ "${LATEST_VERSION}" = "${CURRENT_VERSION}.rpm" ]; then
    echo "All up to date. Current release is";
    echo "${CURRENT_VERSION}";
    exit 0;
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
