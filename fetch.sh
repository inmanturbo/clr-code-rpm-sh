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
    echo "Already up to date";
    exit 1;
else
    echo "Latest version:" ${LATEST_VERSION};
    echo "Current version:" ${CURRENT_VERSION};
fi;
echo "Downloading . . ."


PREFIX="Downloads/${LATEST_VERSION}";

mkdir -p ${PREFIX};

wget -c --https-only ${LATEST_VERSION_URL} -O "${PREFIX}/code-stable-latest.tar.gz";

tar -xf "${PREFIX}/code-stable-latest.tar.gz";

if test -d ~/.VSCode-linux-x64 ; then

    rm -rf ~/.VSCode-linux-x64
fi


mv VSCode-linux-x64 ~/.VSCode-linux-x64;
chmod +x ~/.VSCode-linux-x64/bin/code

if test -d /usr/local/bin ; then
    echo "Entering sudo mode . . ."
    echo "Removing stale links . . ."
    sudo unlink /usr/local/bin/code;
    echo "symlinking . . ."
    echo "Entering sudo mode . . ."
    sudo ln -sv ~/.VSCode-linux-x64/bin/code /usr/local/bin
    else
        echo "/usr/local/bin does not exist, Creating . . ."
        echo "Entering sudo mode . . ."
        sudo mkdir -p /usr/local/bin
        echo "symlinking . . ."
        sudo ln -sv ~/.VSCode-linux-x64/bin/code /usr/local/bin
fi

command -v code >/dev/null 2>&1 || { echo >&2 "Installation failed."; exit 1; }

echo "Success. Code is in ~/.VSCode-linux-x64";

exit 0;
