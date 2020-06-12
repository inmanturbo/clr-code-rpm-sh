#!/bin/bash

########## Add the vscode rpm install to swupd's whitelist on Clear Linux ####################
#Check for permissions
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

#prepare whitelist
WHITELIST="/user/share/applications/code-url-handler.desktop|/usr/share/applications/code.desktop|/usr/share/bash-completion/completions/code|/usr/share/code|/usr/share/code/|/usr/bin/code";
SWUP_DIR=/etc/swupd;
CONFIG="${SWUP_DIR}/config";
if test -f "${CONFIG}"; then
    echo "${CONFIG} aleady exists. Please add";
    echo "";
    echo "${WHITELIST}";
    echo "";
    echo "To your picky_whitelist in ${CONFIG} manually";
    echo "Then return to this directory and run:";
    echo "make check" 
    exit 1;
fi

mkdir -p /etc/swupd/;
echo "";
cp -prv /usr/share/defaults/swupd/* ${SWUP_DIR};
PICKY_WHITELIST_FILE=${SWUP_DIR}/code_picky_whitelist;
echo ${WHITELIST} > ${SWUP_DIR}/code_picky_whitelist
echo "";
cat ${PICKY_WHITELIST_FILE} | tr -d "[:space:]";
echo "";
# Write Whitelist
PICKY_WHITELIST=$(cat ${PICKY_WHITELIST_FILE});
sed -i "/\[diagnose\]/a picky_whitelist=${PICKY_WHITELIST}" "$CONFIG";
sed -i "/\[repair\]/a picky_whitelist=${PICKY_WHITELIST}" "$CONFIG";

echo "Done. Run 'sudo swupd diagnose --picky' to confirm success";
exit 0;
