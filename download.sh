#! /bin/bash

## download latest generic rpm for vscode ##
command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed.  Aborting."; exit 1; }
command -v wget >/dev/null 2>&1 || { echo >&2 "I require wget but it's not installed.  Aborting."; exit 1; }

LATEST_VERSION_URL=$(curl -sS https://update.code.visualstudio.com/api/update/linux-x64/stable/latest| jq -r '.url');
wget -c ${LATEST_VERSION_URL} -O code-stable-latest.tar.gz;

exit 0;
