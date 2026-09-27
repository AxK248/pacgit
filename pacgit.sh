#!/bin/bash
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NO='\033[0m'
printf -n "%bpacgit package [? mb]%b\n" ${CYAN} ${NO}
printf -n "Do you want to download this package? (Y/n): "
read action

action=$(echo "$action" | tr '[:upper:]' '[:lower:]')

case "$action" in
    "Y"|"Yes"|"")
    printf "%bPreparation...%b\n" ${cyan} ${no}
    sudo mkdir -p /opt/pacgit
    printf "%bDownloading package%b\n" ${cyan} ${no}
    git clone -b common https://github.com/AxK248/pacgit/ /opt/pacgit
    chmod +x /opt/pacgit/pacgit
    sudo ln -sf /opt/pacgit/pacgit /usr/local/bin/pacgit
    chmod +x /usr/local/bin/pacgit
    printf "%bDownloading and installing pacgit is completed%b\n" ${green} ${no}
    echo If you want to use this package github manager enter pacgit command.
    exit 0
    ;;
    "N"|"No")
    printf "%bUser canceled install.%b\n" ${red} ${no}
    exit 1
    ;;
