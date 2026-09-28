#!/bin/bash
cyan='\033[0;36m'
green='\033[0;32m'
red='\033[0;31m'
no='\033[0m'

printf "${cyan}pacgit package [? mb]${no}"
printf "${no}
"
read -p "Do you want to download this package? (Y/n): " action </dev/tty

action=$(echo "$action" | tr -d '\r' | tr '[:upper:]' '[:lower:]')

case "$action" in
    "y"|"yes")
    printf "${cyan}Preparation...${no}"
    sudo mkdir -p /opt/pacgit
    printf "${cyan}Downloading package${no}"
    git clone -b common https://github.com/AxK248/pacgit/ /opt/pacgit
    chmod +x /opt/pacgit/pacgit
    sudo ln -sf /opt/pacgit/pacgit /usr/local/bin/pacgit
    chmod +x /usr/local/bin/pacgit
    printf "${green}Downloading and installing pacgit is completed${no}"
    echo "If you want to use this package github manager enter pacgit command."
    exit 0
    ;;
    "n"|"no")
    printf "${red}User canceled install.${no}"
    exit 1
    ;;
    *)
    printf "${red}Invalid choice. Exiting.${no}"
    exit 1
    ;;
esac
