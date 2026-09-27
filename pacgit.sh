#!/bin/bash
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NO='\033[0m'
echo pacgit package [? mb]
echo -n "${CYAN}Do you want to download this package? (Y/n): ${NO}"
read action

action=$(echo "$action" | tr '[:upper:]' '[:lower:]')

case "$action" in
    "Y"|"Yes"|"")
    echo Preparation...
    sudo mkdir -p /opt/pacgit
    echo ${CYAN}Downloading package${NO}
    git clone -b common https://github.com/AxK248/pacgit/ /opt/pacgit
    chmod +x /opt/pacgit/pacgit
    sudo ln -sf /opt/pacgit/pacgit /usr/local/bin/pacgit
    chmod +x /usr/local/bin/pacgit
    echo ${GREEN}Downloading and installing pacgit is completed${NO}
    echo If you want to use this package github manager enter pacgit command.
    exit
    ;;
    "N"|"No")
    ${RED}echo User canceled install.
    exit
    ;;
