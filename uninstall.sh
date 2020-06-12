#!/bin/bash

########## Uninstall VSCODE from rpm on Clear Linux####################

#Check for permissions
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

# Check for rpm 
command -v rpm >/dev/null 2>&1 || { echo >&2 "I require rpm but it's not installed.  Aborting."; exit 1; }

# Remove code
rpm -e code;
