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

# --- РАЗВЕТВЛЕНИЕ КОДА ---

if [ "$OS" = "windows" ]; then
:: Windows
    echo -e

else
:: Linux
    echo -e "${cyan}pacgit package [SIZE]${no}"
    read -p "Do you want to download this package? (Y/n): " action </dev/tty

    action=$(echo "$action" | tr -d '\r' | tr '[:upper:]' '[:lower:]')

    case "$action" in
        "y"|"yes")
        echo -e "${cyan}Preparation...${no}"
        sudo mkdir -p /opt/pacgit
        echo -e "${cyan}Downloading package${no}"
        git clone -b common https://github.com/AxK248/pacgit/ /opt/pacgit
        chmod +x /opt/pacgit/pacgit
        sudo ln -sf /opt/pacgit/pacgit /usr/local/bin/pacgit
        chmod +x /usr/local/bin/pacgit
        echo -e "${green}Downloading and installing pacgit is completed${no}"
        echo "If you want to use this package github manager enter 'pacgit' command."
        exit 0
        ;;
        "n"|"no")
        echo -e "${cyan}User ${red}canceled ${cyan}install.${no}"
        exit 1
        ;;
        *)
        echo -e "${red}Invalid choice. Exiting.${no}"
        exit 1
        ;;
    esac

fi
