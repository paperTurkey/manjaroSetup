#!/bin/bash

##########################################################
#             Mat's Manjaro Setup Script                 #
#   Manjaro Applications Automatic Installation Script   #
##########################################################
#  +FIRST     : sudo chmod +x manjaroSetup.sh            #
#             (Give EXEC Access To Script)               #
#  +TO RUN    : sudo ./manjaroSetup.sh                   #
##########################################################

# Variables
# Formatting
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'
# Pathing
spath="$( cd "$( dirname $0 )" && pwd )"

##########################################################
#                      First Component                   #
##########################################################

# install script if not installed
function installManjaroSetup {
if [ ! -e "/usr/bin/ManjaroSetup" ];then
    echo -en "\e[32m[-] : Script is not installed. Do you want to install it ? (Y/N) !\e[0m"
    read install
    if [[ $install = Y || $install = y ]] ; then
        wget https://github.com/paperTurkey/manjaroSetup/blob/master/manjaroSetup.sh -O /usr/bin/ManjaroSetup
        chmod +x /usr/bin/ManjaroSetup
        echo "Manjaro Setup should now be installed. Launching it !"
        sleep 1
    echo "You can run the script anytime by typing 'ManjaroSetup' in the terminal."
    sleep 2

        ManjaroSetup
        exit 1
    else
        echo -e "\e[32m[-] Ok, maybe later then... !\e[0m"
    fi
else
    echo "Manjaro Setup Script is installed"
    sleep 1
fi
}

# Validate OS Architecture
function archicheck {
  if [[ $(uname -m ) = x86_64 ]]; then
    sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
  else
    echo -e "\e[32m[-] multilab is already Enabled !\e[0m"
	   #sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
  fi
}

# Manjaro Setup Logo
function showlogo {
  clear
  echo """
  ███╗   ███╗ █████╗ ███╗   ██╗     ██╗ █████╗ ██████╗  ██████╗     ███████╗███████╗████████╗██╗   ██╗██████╗      ██╗    ██████╗
  ████╗ ████║██╔══██╗████╗  ██║     ██║██╔══██╗██╔══██╗██╔═══██╗    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗    ███║   ██╔═████╗
  ██╔████╔██║███████║██╔██╗ ██║     ██║███████║██████╔╝██║   ██║    ███████╗█████╗     ██║   ██║   ██║██████╔╝    ╚██║   ██║██╔██║
  ██║╚██╔╝██║██╔══██║██║╚██╗██║██   ██║██╔══██║██╔══██╗██║   ██║    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝      ██║   ████╔╝██║
  ██║ ╚═╝ ██║██║  ██║██║ ╚████║╚█████╔╝██║  ██║██║  ██║╚██████╔╝    ███████║███████╗   ██║   ╚██████╔╝██║          ██║██╗╚██████╔╝
  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝     ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝          ╚═╝╚═╝ ╚═════╝
""";
  echo
}

# Root User Check
function checkroot {
  showlogo && sleep 1
  if [[ $(id -u) = 0 ]]; then
    echo -e " Checking for ROOT: ${g}PASSED${endc}"
  else
    echo -e " Checking for ROOT: ${r}FAILED${endc}
    ${y}This Setup Script Needs To Run As ROOT${endc}"
    echo -e " ${b}ManjaroSetup.sh${enda} Will Now Exit"
    echo
    sleep 1
    exit
  fi
}

# First pacman -Syu
function initpacmanupd {
  echo ""
  echo; echo -e "\033[1m Updating ..... \e[0m\E[31m| Please stop any install process before updating\e[0m";
  echo
  pacman -Syu --noconfirm;
  echo "Update Finished";
  sleep 1;
}

# Requirements Check

function checkyay {
  which yay > /dev/null 2>&1
  if [ "$?" -eq "0" ]; then
    echo [✔]::[Yay]: installation found!;
  else
    echo [x]::[warning]:this script require Yay ;
    echo ""
    echo [!]::[please wait]: Installing Yay ..  ;
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    echo ""
  fi
sleep 1
}


function checkgit {
	which git > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	  echo [✔]::[Git]: installation found!;
  else
    echo [x]::[warning]:this script require Git ;
    echo ""
    echo [!]::[please wait]: Installing Git ..  ;
    pacman -S git --noconfirm
    echo ""
  fi
sleep 1
}

function checkwget {
	which wget > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
    echo [✔]::[wget]: installation found!;
  else
    echo [x]::[warning]:this script require wget ;
    echo ""
    echo [!]::[please wait]: Installing Wget ;
    pacman -S --noconfirm wget
    echosleep 2
    echo ""
  fi
sleep 1
}

# Script Initiation
checkroot && sleep 1
checkwget && checkyay && checkgit && sleep 1
showlogo && echo -e " ${y} Preparing to Run ${b}MajaroSetup${endc}"
archicheck && initpacmanupd && clear && installManjaroSetup && sleep 1

##########################################################
#                      Second Component                  #
##########################################################

# Package Installations

# Install Okular
function installokular {
  echo
  echo -e " Currently installing ${b}Okular${enda}"
  echo -e "${bu}Okular is a universal document viewer developed by KDE."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Okular${endc}"
  pacman -S okular --noconfirm
  echo && echo -e "${b}Okular${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install GParted
function installgparted {
  echo
  echo -e " Currently installing ${b}GParted${enda}"
  echo -e "${bu}GParted is a free partition editor for graphically managing your dis partitions."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}GParted${endc}"
  pacman -S gparted --noconfirm
  echo && echo -e "${b}GParted${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

##########################################################
#                      Third Component                   #
##########################################################

# Menu for download managers
function downmanage {
  showlogo
  echo -e " ${b}[ Download Managers ]${enda}"
  echo -e "Make a choice:
              1. gwget
              2. kget
              3. uget
              ----------------------
              q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installgwget ;;
    2) installkget ;;
    3) installuget ;;
    q) sleep 1 ;;
    *) echo " \"$option\" is not a valid option"; sleep 1; downmanage ;;
  esac
}

# Menu for VPN Clients
function showvpn {
  showlogo
  echo -e "${b}[ VPN Clients ]${enda}"
  echo -e "Make a choice:
            1. OpenConnect
            2. PPTP Client
            ----------------------
            q. Return to ROOT Menu"
  echosleepecho -en " Choose an option: "
  read option
  case $option in
    1) installopenconnect ;;
    2) installpptpclient ;;
    q) sleep 1 ;;
    *) echo " \"$option\" is not a valid option"; sleep 1; showvpn ;;
  esac
}

# Menu for FTP/Torrent Applications

# Menu for Chat Applications

# Menu for Image Editors

# Menu for Archive Handlers

# Menu for Text Editors

# Menu for Web Applications

# Menu for Development Environments

# Menu for Browser Links

# Menu for Dotfiles

# Menu for Rando Applications

# Menu for Network Managers

# Loop to Show Menu Until Exit
while :
do
  showlogo
  echo -e " ${b}[ROOT Menu ]${enda}"
  echo -e "Make a choice:
            1. Download Managers
            2. VPN Clients
            3. FTP Torrent Applications
            4. Chat Applications
            5. Image Editors
            6. Archive Handlers
            7. Text Editors
            8. Web Applications
            9. Development Environments
            10. Network Managers
            11. Rando Applications
            12. Browser Links
            13. Dotfiles
            ---------------------------
            a. About ManjaroSetup
            q. Leave ManjaroSetup"
  echo
  echo -en " Choose an option: "
  case $option in
    1) downmanage ;;
    2) showvpn ;;
    3) showftporr ;;
    4) showchat ;;
    5) showimg ;;
    6) showarch ;;
    7) showtext ;;
    8) showwebapps ;;
    9) showdevenvs ;;
    10) netmanage ;;
    11) showrandoapps ;;
    12) showlinks ;;
    13) showdotfiles ;;
    a) showabout ;;
    q) manjarosetupexit ;;
    *) echo " \"$option\" is not a valid option"; sleep 1 ;;
  esac

# Show About
function showabout {
  clear
  echo -e "
  ##########################################################
  #             Mat's Manjaro Setup Script                 #
  #   Manjaro Applications Automatic Installation Script   #
  ##########################################################
  #  -- Operating System: Manjaro                          #
  #  -- Version: v1.0 03 March 2021                        #
  #  -- Thanks: Sofiane Hamlaoui for the original!         #
  #  -- https://github.com/SofianeHamlaoui/ArchI0          #
  ##########################################################
  "
}

done
# End
