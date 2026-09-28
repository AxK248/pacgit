#!/bin/bash
cyan='\033[0;36m'
green='\033[0;32m'
red='\033[0;31m'
no='\033[0m'
case "$(uname -s)" in
    *MINGW*|*MSYS*)
        OS="windows"
        ;;
    Linux)
        OS="linux"
        ;;
    *)
        echo "${red}WARNING${no}: Operation system not supported!" >&2
        exit 1
        ;;
esac

if [ "$OS" = "windows" ]; then
#Windows
    echo -e "${cyan}pacgit package [SIZE]${no}"
    echo -e "${cyan}pacwin package for windows version pacgit [SIZE]${no}"
    read -p "Do you want download this packages? (Y/n): " actionwin </dev/tty

    actionwin=$(echo "$actionwin" | tr -d '\r' | tr '[:upper:]' '[:lower:]')

    case "$actionwin" in
       "y"|"yes")
       echo -e "${cyan}Preparation...${no}"
       mkdir -p /opt/pacgit
       echo -e "${cyan}Downloading packages...${no}"
       git clone -b common https://github.com/AxK248/pacgit/ /opt/pacgit
       git clone -b windows https://github.com/AxK248/pacgit/ /opt/pacgit/lib64win
       echo -e "${green}Downloading packages completed.${no}"
       echo -e "${cyan}Starting configuration...${no}"
       /opt/pacgit/lib64win/install-config.bat
       echo -e "${green}Configuration completed.${no}"
       /opt/pacgit/lib64win/tools/restart-explorer.bat
       echo -e "${green}Complete.${no}"
       exit 0
       ;;
       "n"|"no")
       echo -e "User ${red}cancaled ${no}install."
       exit 1
       ;;
       *)
       echo -e "${red}Invalid choose $actionwin.${no}"
    esac
exit 1
fi

elif [ "$OS" = "linux" ]; then
#Linux
    echo -e "${cyan}pacgit package [SIZE]${no}"
    read -p "Do you want to download this package? (Y/n): " action </dev/tty

    action=$(echo "$action" | tr -d '\r' | tr '[:upper:]' '[:lower:]')

    case "$action" in
        "y"|"yes")
        echo -e "${cyan}Preparation...${no}"
        sudo mkdir -p /opt/pacgit
        echo -e "${cyan}Downloading package${no}"
        git clone -b common https://github.com/AxK248/pacgit/ /opt/pacgit
        chmod +x /opt/pacgit/pacgit.sh
        sudo ln -sf /opt/pacgit/pacgit /usr/local/bin/pacgit
        chmod +x /usr/local/bin/pacgit
        echo -e "${green}Downloading and installing pacgit is completed${no}"
        echo "If you want to use this package github manager enter 'pacgit' command."
        exit 0
        ;;
        "n"|"no")
        echo -e "User ${red}canceled ${no}install."
        exit 1
        ;;
        *)
        echo -e "${red}Invalid choice $action.${no}" 
        ;;
    esac

fi
