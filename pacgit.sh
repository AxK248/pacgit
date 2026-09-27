#!/bin/bash
cyan='\033[0;36m'
green='\033[0;32m'
red='\033[0;31m'
no='\033[0m'

printf "%bpacgit package [? mb]%b\n" "${cyan}" "${no}"
printf "Do you want to download this package? (Y/n): "
read action

action=$(echo "$action" | tr -d '\r' | tr '[:upper:]' '[:lower:]')

case "$action" in
    "y"|"yes"|"")
    printf "%bPreparation...%b\n" "${cyan}" "${no}"
    sudo mkdir -p /opt/pacgit
    printf "%bDownloading package%b\n" "${cyan}" "${no}"
    git clone -b common https://github.com/AxK248/pacgit/ /opt/pacgit
    chmod +x /opt/pacgit/pacgit
    sudo ln -sf /opt/pacgit/pacgit /usr/local/bin/pacgit
    chmod +x /usr/local/bin/pacgit
    printf "%bDownloading and installing pacgit is completed%b\n" "${green}" "${no}"
    echo "If you want to use this package github manager enter pacgit command."
    exit 0
    ;;
    "n"|"no")
    printf "%bUser canceled install.%b\n" "${red}" "${no}"
    exit 1
    ;;
    *)
    printf "%bInvalid choice. Exiting.%b\n" "${red}" "${no}"
    exit 1
    ;;
esac
