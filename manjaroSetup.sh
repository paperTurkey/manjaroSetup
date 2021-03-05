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
        wget https://raw.githubusercontent.com/paperTurkey/manjaroSetup/master/manjaroSetup.sh -O /usr/bin/ManjaroSetup
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
  ███╗   ███╗ █████╗ ███╗   ██╗     ██╗ █████╗ ██████╗  ██████╗
  ████╗ ████║██╔══██╗████╗  ██║     ██║██╔══██╗██╔══██╗██╔═══██╗
  ██╔████╔██║███████║██╔██╗ ██║     ██║███████║██████╔╝██║   ██║
  ██║╚██╔╝██║██╔══██║██║╚██╗██║██   ██║██╔══██║██╔══██╗██║   ██║
  ██║ ╚═╝ ██║██║  ██║██║ ╚████║╚█████╔╝██║  ██║██║  ██║╚██████╔╝
  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
███████╗███████╗████████╗██╗   ██╗██████╗      ██╗    ██████╗
██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗    ███║   ██╔═████╗
███████╗█████╗     ██║   ██║   ██║██████╔╝    ╚██║   ██║██╔██║
███████╗█████╗     ██║   ██║   ██║██████╔╝    ╚██║   ██║██╔██║
╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝      ██║   ████╔╝██║
███████║███████╗   ██║   ╚██████╔╝██║          ██║██╗╚██████╔╝
╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝          ╚═╝╚═╝ ╚═════╝
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
    sudo pacman -Su binutils make gcc pkg-config fakeroot --noconfirm
    echo ""
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
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
#         Second Component - Package Installers          #
##########################################################

# Install Wifi Menu
function installwifimenu {
  echo -e " Preparing To Install ${b}wifi-menu${enda}" && echo
  echo -e " ${bu}wifi-menu is a service for connecting to the wifi points
  using wpa_supplicant."
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}wifi-menu${enda}"
  pacman -S --noconfirm wifi-menu dialog wpa_supplicant
  echo -e " ${b}wifi-menu${enda} Was Successfully Installed"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

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

# Install Emacs
function installemacs {
  echo
  echo -e " Currently installing ${b}Emacs${enda}"
  echo -e "${bu}GNU Emacs is an extensible, customizable text editor and more!"
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Emacs${endc}"
  pacman -S --noconfirm emacs
  echo && echo -e "${b}Emacs${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install GEdit
function installgedit {
  echo
  echo -e " Currently installing ${b}GEdit${enda}"
  echo -e "${bu}GEdit is a text editor for the GNOME desktop environment, Mac OSX and Microsoft Windows."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}GEdit${endc}"
  pacman -S --noconfirm gedit
  echo && echo -e "${b}GEdit${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Geany
function installgeany {
  echo
  echo -e " Currently installing ${b}Geany${enda}"
  echo -e "${bu}Geany is a text editor using the GTK2 toolkit with basic features of an integrated development environment."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Geany${endc}"
  pacman -S --noconfirm geany
  echo && echo -e "${b}Geany${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install FileZilla
function installfilez {
  echo
  echo -e " Currently installing ${b}FileZilla${enda}"
  echo -e "${bu}FileZilla is a free, open source FTP client."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}FileZilla${endc}"
  pacman -S --noconfirm filezilla
  echo && echo -e "${b}FileZilla${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install gFTP
function installgftp {
  echo
  echo -e " Currently installing ${b}gFTP${enda}"
  echo -e "${bu}gFTP is a free/open source multithreaded FTP client."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}gFTP${endc}"
  pacman -S --noconfirm gftp
  echo && echo -e "${b}gFTP${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Transmission
function installtransmission {
  echo
  echo -e " Currently installing ${b}Transmission${enda}"
  echo -e "${bu}Transmission is designed for easy, poweful use."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Transmission${endc}"
  pacman -S --noconfirm transmission-qt
  echo && echo -e "${b}Transmission${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Ark
function installark {
  echo
  echo -e " Currently installing ${b}Ark${enda}"
  echo -e "${bu}Ark is a program for managing various archive formats (RAR, ZIP, ...) within the KDE environment."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Ark${endc}"
  pacman -S --noconfirm ark
  echo && echo -e "${b}Ark${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install fileroller
function installfileroller {
  echo
  echo -e " Currently installing ${b}File-Roller${enda}"
  echo -e "${bu}File-Roller is an archive manager of the GNOME desktop environment."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}File-Roller${endc}"
  pacman -S --noconfirm file-roller
  echo && echo -e "${b}File-Roller${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Zip/Unzip
function installzipunzip {
  echo
  echo -e " Currently installing ${b}Zip/Unzip${enda}"
  echo -e "${bu}Zip/Unzip is a archive tool commonly found on MS-DOS systems."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Zip/Unzip${endc}"
  pacman -S --noconfirm unzip
  echo && echo -e "${b}Zip/Unzip${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Rar/Unrar
function installrarunrar {
  echo
  echo -e " Currently installing ${b}Rar/Unrar${enda}"
  echo -e "${bu}Rar/Unrar is a archival compression tool for the terminal."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Rar/Unrar${endc}"
  pacman -S --noconfirm rar unrar
  echo && echo -e "${b}Rar/Unrar${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Chromium
function installchromium {
  echo
  echo -e " Currently installing ${b}Chromium${enda}"
  echo -e "${bu}Chromium is an open-source browser project."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Chromium${endc}"
  pacman -S --noconfirm chromium
  echo && echo -e "${b}Chromium${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Google Chrome
function installchrome {
  echo
  echo -e " Currently installing ${b}Google Chrome${enda}"
  echo -e "${bu}Chrome is a freeware web browser developed by Google."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Chrome${endc}"
  yay -S google-chrome
  echo && echo -e "${b}${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Youtube Downloader
function installytbdwn {
  echo
  echo -e " Currently installing ${b}Youtube Downloader${enda}"
  echo -e "${bu}Simple Youtube Video Downloader is exactly what it says it is."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Youtube Downloader${endc}"
  pacman -S --noconfirm youtube-dl
  echo && echo -e "${b}Youtube Downloader${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Connman
function installconnman {
  echo
  echo -e " Currently installing ${b}Connman${enda}"
  echo -e "${bu}Connman is a daemon for managing internet connections within embedded devices running the Linux operating system."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Connman${endc}"
  pacman -S --noconfirm connman
  echo && echo -e "${b}Connman${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Skype
function installskype {
  echo
  echo -e " Currently installing ${b}Skype${enda}"
  echo -e "${bu}Skype is a freemium VOIP service and instant messaging client."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Skype${endc}"
  yay -S skype
  echo && echo -e "${b}Skype${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Teamviewer
function installteamviewer {
  echo
  echo -e " Currently installing ${b}Teamviewer${enda}"
  echo -e "${bu}Teamviewer is a proprietary computer software package for remote control, desktop sharing, online meeting, web conferencing and file transfer between computers."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Teamviewer${endc}"
  yay -S teamviewer
  echo && echo -e "${b}Teamviewer${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Terminator
function installterminator {
  echo
  echo -e " Currently installing ${b}Terminator${enda}"
  echo -e "${bu}Terminator is a useful tool for arranging terminals."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Terminator${endc}"
  pacman -S --noconfirm terminator
  echo && echo -e "${b}Terminator${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Gnome Tweak Tool
function installgnometweaktool {
  echo
  echo -e " Currently installing ${b}Gnome Tweak Tool${enda}"
  echo -e "${bu}Gnome Tweak Tool is a tool to customize advanced GNOME 3 options."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Gnome Tweak Tool${endc}"
  pacman -S --noconfirm gnome-tweak-tool
  echo && echo -e "${b}Gnome Tweak Tool${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install netctl
function installnetctlr {
  echo
  echo -e " Currently installing ${b}netctl${enda}"
  echo -e "${bu}netctl is a simple and robust tool to manage network connections via profiles."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}netctl${endc}"
  pacman -S --noconfirm netctl
  echo && echo -e "${b}${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install NetworkManager
function installnetworkmanager {
  echo
  echo -e " Currently installing ${b}NetworkManager${enda}"
  echo -e "${bu}NetworkManager is a tool that provides wired, wireless, mobile boradband and OpenVPN detection with configuration and automatic connection."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}NetworkManager${endc}"
  pacman -S --noconfirm networkmanager
  echo && echo -e "${b}NetworkManager${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install systemd-networkd
function installsystemnet {
  echo
  echo -e " Currently installing ${b}systemd-networkd${enda}"
  echo -e "${bu}systemd-networkd is a native daemon that manages network configuration."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}systemd-networkd${endc}"
  pacman -S --noconfirm systemd
  echo && echo -e "${b}systemd-networkd${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Wicd
function installwicd {
  echo
  echo -e " Currently installing ${b}Wicd${enda}"
  echo -e "${bu}Wicd is a wireless and wired connection manager."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Wicd${endc}"
  pacman -S --noconfirm wicd
  echo && echo -e "${b}Wicd${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install OpenConnect
function installopenconnect {
  echo
  echo -e " Currently installing ${b}OpenConnect${enda}"
  echo -e "${bu}OpenConnect is a client for Cisco's AnyConnect SSL VPN."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}OpenConnect${endc}"
  pacman -S --noconfirm openconnect
  echo && echo -e "${b}OpenConnect${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install PPTP Client
function installpptpclient {
  echo
  echo -e " Currently installing ${b}PPTP Client${enda}"
  echo -e "${bu}PPTP Client is a program implementing the Microsoft PPTP protocol."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}PPTP Client${endc}"
  pacman -S --noconfirm pptpclient
  echo && echo -e "${b}PPTP Client${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Firefox
function installfirefox {
  echo
  echo -e " Currently installing ${b}Firefox${enda}"
  echo -e "${bu}Firefox is a free and open-source web browser developed by the Mozilla Foundation."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Firefox${endc}"
  pacman -S --noconfirm firefox
  echo && echo -e "${b}${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Youtube Downloader GUI
function installytgui {
  echo
  echo -e " Currently installing ${b}Youtube Downloader (GUI)${enda}"
  echo -e "${bu}Youtube Downloader (GUI) is a cross platform front-end GUI of the popular youtube-dl."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Youtube Downloader (GUI)${endc}"
  yay -S youtube-dl-gui-git
  echo && echo -e "${b}Youtube Downloader (GUI)${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install VLC
function installvlc {
  echo
  echo -e " Currently installing ${b}VLC${enda}"
  echo -e "${bu}VLC is a free and open source cross-platform multimedia player and framework that plays most multimedia files."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}VLC${endc}"
  pacman -S --noconfirm vlc
  echo && echo -e "${b}VLC${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Gwget
function installgwget {
  echo
  echo -e " Currently installing ${b}Gwget${enda}"
  echo -e "${bu}Gwget is a download manager for the Gnome Desktop."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Gwget${endc}"
  pacman -S --noconfirm gwget
  echo && echo -e "${b}Gwget${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install kget
function installkget {
  echo
  echo -e " Currently installing ${b}KGet${enda}"
  echo -e "${bu}KGet is a free download manager for KDE."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}KGet${endc}"
  pacman -S --noconfirm kdenetwork-kget
  echo && echo -e "${b}KGet${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Uget
function installuget {
  echo
  echo -e " Currently installing ${b}uGet${enda}"
  echo -e "${bu}uGet is a powerful download manager application with a large inventory of features."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}uGet${endc}"
  pacman -S --noconfirm uget
  echo && echo -e "${b}uGet${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install curlftpfs
function installcurlftpfs {
  echo
  echo -e " Currently installing ${b}Curl ftpFS${enda}"
  echo -e "${bu}Curl FtpFS is a filesystem for accessing FTP hosts based on FUSE and libcurl."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Curl ftpFS${endc}"
  pacman -S --noconfirm curlftpfs
  echo && echo -e "${b}Curl ftpFS${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install qBittorrent
function installqbittorrent {
  echo
  echo -e " Currently installing ${b}qBittorrent${enda}"
  echo -e "${bu}qBittorrent is a cross-platform client for the BitTorrent protocol."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}qBittorrent${endc}"
  pacman -S --noconfirm qbittorrent qbittorrent-nox
  echo && echo -e "${b}qBittorrent${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Kmail
function installkmail {
  echo
  echo -e " Currently installing ${b}Kmail${enda}"
  echo -e "${bu}Kmail is a mail client that supports folders, filtering, viewing HTML mail, and international character sets."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Kmail${endc}"
  pacman -S --noconfirm kmail
  echo && echo -e "${b}Kmail${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Hexchat
function installhexchat {
  echo
  echo -e " Currently installing ${b}HexChat${enda}"
  echo -e "${bu}HexChat is an open-source IRC client based on XChat."
  echo && echo -en " ${y}Press enter to continue...${endc}"echo
  read input
  echo -e " Installing ${b}HexChat${endc}"
  pacman -S --noconfirm hexchat
  echo && echo -e "${b}${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Quassel
function installquassel {
  echo
  echo -e " Currently installing ${b}Quassel${enda}"
  echo -e "${bu}Quassel is a cross-platform IRC client introduced in 2008. "
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Quassel${endc}"
  pacman -S --noconfirm quassel-core quassel-client quassel-monolithic
  echo && echo -e "${b}Quassel${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Discord
function installdiscord {
  echo
  echo -e " Currently installing ${b}Discord${enda}"
  echo -e "${bu}Discord is a all-in-one voice and text chat client."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Discord${endc}"
  yay -S discord
  echo && echo -e "${b}Discord${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install FFmpeg
function installffmpeg {
  echo
  echo -e " Currently installing ${b}FFmpeg${enda}"
  echo -e "${bu}FFmpeg is a cross-platform solution to record, convert and stream audio and video."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}FFmpeg${endc}"
  pacman -S --noconfirm ffmpeg
  echo && echo -e "${b}FFmpeg${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Liferea
function installliferea {
  echo
  echo -e " Currently installing ${b}Liferea${enda}"
  echo -e "${bu}Liferea is a Linux Feed Reader."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Liferea${endc}"
  pacman -S --noconfirm liferea
  echo && echo -e "${b}Liferea${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install VIM
function installvim {
  echo
  echo -e " Currently installing ${b}VIM${enda}"
  echo -e "${bu}VIM is an improved and highly configurable GUI version of the text editor."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}${endc}"
  pacman -S --noconfirm gvim
  echo && echo -e "${b}VIM${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Kate
function installkate {
  echo
  echo -e " Currently installing ${b}Kate${enda}"
  echo -e "${bu}Kate is short for KDE Advanced Text Editor."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Kate${endc}"
  pacman -S --noconfirm kate
  echo && echo -e "${b}Kate${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Atom
function installatom {
  echo
  echo -e " Currently installing ${b}Atom${enda}"
  echo -e "${bu}Atom is an open-source text editor developed by GitHub."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Atom${endc}"
  yay -S atom
  echo && echo -e "${b}Atom${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Bluefish
function installbluefish {
  echo
  echo -e " Currently installing ${b}Bluefish${enda}"
  echo -e "${bu}Bluefish is a GTK+ editor/IDE with an MDI interface and syntax highlighting."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Bluefish${endc}"
  pacman -S --noconfirm bluefish
  echo && echo -e "${b}Bluefish${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Brackets
function installbrackets {
  echo
  echo -e " Currently installing ${b}Brackets${enda}"
  echo -e "${bu}Brackets is an open-source editor written in HTML, CSS, and Javascript with a primary focus on Web Development."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Brackets${endc}"
  yay -S brackets
  echo && echo -e "${b}Brackets${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Cloud9
function installcloud9 {
  echo
  echo -e " Currently installing ${b}Cloud9${enda}"
  echo -e "${bu}Cloud9 is a state-of-the-art IDE that runs in the browser and lives in the cloud, allowing you to run, debug, and deploy apps from anywhere."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Cloud9${endc}"
  yay -S c9.core
  echo && echo -e "${b}Cloud9${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install IntelliJIDEA
function installintellij {
  echo
  echo -e " Currently installing ${b}IntelliJ IDEA${enda}"
  echo -e "${bu}IntelliJ is an IDE for Java, Groovy, and other programming languages with advanced refactoring features."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}IntelliJ${endc}"
  pacman -S --noconfirm intellij-idea-community-edition
  echo && echo -e "${b}IntelliJ${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Netbeans
function installnetbeans {
  echo
  echo -e " Currently installing ${b}Netbeans${enda}"
  echo -e "${bu}Netbeans is an IDE for developing Java, JS, PHP, Python, Ruby, etc."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Netbeans${endc}"
  pacman -S --noconfirm netbeans
  echo && echo -e "${b}Netbeans${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Ninja-IDE
function installninja {
  echo
  echo -e " Currently installing ${b}Ninja-IDE${enda}"
  echo -e "${bu}Ninja-IDE is a cross-platform IDE."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Ninja-IDE${endc}"
  pacman -S --noconfirm ninja-ide
  echo && echo -e "${b}Ninja-IDE${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Sublime Text
function installsublime {
  echo
  echo -e " Currently installing ${b}Sublime Text 2${enda}"
  echo -e "${bu}Sublime Text 2 is a closed-source C++ and Python-based editor."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Sublime Text 2${endc}"
  pacman -S --noconfirm sublime-text sublime-text-dev
  echo && echo -e "${b}Sublime Text 2${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Visual Studio Code
function installvisualstudiocode {
  echo
  echo -e " Currently installing ${b}Visual Studio Code${enda}"
  echo -e "${bu}Visual Studio Code is an editor for building and debugging modern web and cloud applications."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}VS Code${endc}"
  pacman -S --noconfirm code
  echo && echo -e "${b}${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Docky
function installdocky {
  echo
  echo -e " Currently installing ${b}Docky${enda}"
  echo -e "${bu}Docky is an advanced shortcut bar that sits at the edge of your screen."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Docky${endc}"
  pacman -S --noconfirm docky
  echo && echo -e "${b}Docky${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Steam
function installsteam {
  echo
  echo -e " Currently installing ${b}Steam${enda}"
  echo -e "${bu}Steam is a digital distribution platform developed by Valve Corporation."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Steam${endc}"
  pacman -S --noconfirm steam
  echo && echo -e "${b}Steam${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Foxit Reader
function installfoxitreader {
  echo
  echo -e " Currently installing ${b}Foxit Reader${enda}"
  echo -e "${bu}Foxit Reader is a PDF file reader with a lot of features."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Foxit Reader${endc}"
  yay -S foxitreader
  echo && echo -e "${b}Foxit Reader${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Libre Office
function installlibreoffice {
  echo
  echo -e " Currently installing ${b}Libre Office${enda}"
  echo -e "${bu}Libre Office is a open-source software office suite."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Libre Office${endc}"
  pacman -S --noconfirm libreoffice-fresh
  echo && echo -e "${b}Libre Office${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install HardInfo
function installhardinfo {
  echoBT
  echo -e " Currently installing ${b}HardInfo${enda}"
  echo -e "${bu}HardInfo is an app that provides information about your system hardware."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}HardInfo${endc}"
  pacman -S --noconfirm hardinfo
  echo && echo -e "${b}HardInfo${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}

# Install Virtual Box
function installvirtualbox {
  echo
  echo -e " Currently installing ${b}Virtual Box${enda}"
  echo -e "${bu}Virtual Box is a free and open-source hypervisor."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Virtual Box${endc}"
  pacman -S --noconfirm virtualbox qt4
  echo && echo -e "${b}${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
  read input
}



##########################################################
#               Third Component - The Menus              #
##########################################################

# Menu for Text Editors
function showtext {
  showlogo
  echo -e " ${b}[ Text Editors ]${enda}"
  echo -e "Make a choice:
            1. GEdit
            2. Geany
            3. Emacs
            4. VIM
            5. Kate
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installgedit ;;
    2) installgeany ;;
    3) installemacs ;;
    4) installvim ;;
    5) installkate ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
}

# Menu for FTP/Torrent Applications
function showftptorr {
  showlogo
  echo -e " ${b}[ FTP/Torrent Apps ]${enda}"
  echo -e "Make a choice:
            1. FileZilla (FTP)
            2. gFTP (FTP)
            3. Curl ftpFS (FTP)
            4. qBittorrent (Torrent)
            5. Transmission (Torrent)
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installfilez ;;
    2) installgftp ;;
    3) installcurlftpfs ;;
    4) installqbittorrent ;;
    5) installtransmission ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
  esac
}

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

# Menu for Network Managers
function netmanage {
  showlogo
  echo -e " ${b}[ Network Managers ]${enda}"
  echo -e "Make a choice:
            1. Connman
            2. netctl
            3. NetworkManager
            4. Wifi-Menu
            5. systemd-networkd
            6. Wicd
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installconnman ;;
    2) installnetctlr ;;
    3) installnetworkmanager ;;
    4) installwifimenu ;;
    5) installsystemnet ;;
    6) installwicd ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
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
  echo -en " Choose an option: "
  read option
  case $option in
    1) installopenconnect ;;
    2) installpptpclient ;;
    q) sleep 1 ;;
    *) echo " \"$option\" is not a valid option"; sleep 1; showvpn ;;
  esac
}

# Menu for Chat Applications
function showchat {
  showlogo
  echo -e " ${b}[ Chat Applications ]${enda}"
  echo -e "Make a choice:
            1. Kmail
            2. HexChat
            3. Quassel
            4. Geany Mail
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installkmail ;;
    2) installhexchat ;;
    3) installquassel ;;
    4) installgeany ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
}
# Menu for Archive Handlers
function showarch {
  showlogo
  echo -e " ${b}[ Archive Handlers ]${enda}"
  echo -e "Make a choice:
            1. Ark (for KDE)
            2. File-Roller (for GNOME)
            3. Zip/Unzip
            4. Rar/Unrar
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installark ;;
    2) installfileroller ;;
    3) installzipunzip ;;
    4) installrarunrar ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
}

# Menu for Audio Applications
function showaudio {
  showlogo
  echo -e " ${b}[ Audio Applications ]${enda}"
  echo -e "Make a choice:
            1. VLC
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installvlc ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
}

# Menu for Rando Applications
function showothapps {
  showlogo
  echo -e " ${b}[ Rando Applications ]${enda}"
  echo -e "Make a choice:
            1. Skype
            2. TeamViewer
            3. Gnome Tweak Tool
            4. Terminator
            5. Discord
            6. Liferea
            7. Docky
            8. Steam
            9. Foxit Reader
            10. LibreOffice
            11. HardInfo
            12. GParted
            13. VirtualBox
            14. Okular
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installskype ;;
    2) installteamviewer ;;
    3) installgnometweaktool ;;
    4) installterminator ;;
    5) installdiscord ;;
    6) installliferea ;;
    7) installdocky ;;
    8) installsteam ;;
    9) installfoxitreader ;;
    10) installlibreoffice ;;
    11) installhardinfo ;;
    12) installgparted ;;
    13) installvirtualbox ;;
    14) installokular ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
}

# Menu for IDEs
function showdevapps {
  showlogo
  echo -e " ${b}[ Development Environments ]${enda}"
  echo -e "Make a choice:
            1. Bluefish
            2. Brackets
            3. Cloud9
            4. IntelliJ
            5. Netbeans
            6. Ninja-IDE
            7. Sublime Text 2
            8. VS Code
            9. Atom Editor
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installbluefish ;;
    2) installbrackets ;;
    3) installcloud9 ;;
    4) installintellij ;;
    5) installnetbeans ;;
    6) installninja ;;
    7) installsublime ;;
    8) installvisualstudiocode ;;
    9) installatom ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
}

# Menu for Web Applications
function showwebapps {
  showlogo
  echo -e " ${b}[ Web Applications ]${enda}"
  echo -e "Make a choice:
            1. Chromium
            2. Chrome
            3. Firefox
            4. Youtube Downloader (Terminal)
            5. Youtube Downloader (GUI)
            ----------------------
            q. Return to ROOT Menu"
  echo -en " Choose an option: "
  read option
  case $option in
    1) installchromium ;;
    2) installchromium ;;
    3) installfirefox ;;
    4) installytbdwn ;;
    5) installytgui ;;
    q) sleep 1 ;;
    *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
}

# Menu for Dotfiles
function showdotfiles {
  showlogo
  echo -e "${b}[ Dotfiles ]${enda}"
  echo -e " Windelicato: ${bu}https://github.com/windelicato/dotfiles${endc}"
  echo -e " Jieverson: ${bu}https://github.com/jieverson/dotfiles${endc}"
  echo -e " Brianclemens: ${bu}https://github.com/brianclemens/dotfiles${endc}"
  echo -e " Probandula: ${bu}https://github.com/probandula/arch-dotfiles${endc}"
  echo -e " MORE.. : ${bu}https://github.com/bamos/dotfiles#similar-projects-and-inspiration${endc}"
}

# Menu for Browser Links
function showlinks {
  echo -e "${b}[ Useful Links ]${enda}"
  echo -e " PaperTurkey's GitHub: ${bu}https://github.com/paperTurkey${endc}"
  echo -e " Manjaro Linux Wiki: ${bu}https://wiki.manjaro.org/${endc}"
  echo -e " Manjaro User Guide: ${bu}https://manjaro.org/support/userguide/${endc}"
}

# Infinite Loop to Show Menu Until Exit

while :
do
showlogo
echo -e " ${b}[ R00T Menu ]${enda}"
echo -e "Make A Choice
        1)    Text Editors
        2)    FTP/Torrent Applications
        3)    Download Managers
        4)    Network managers
        5)    VPN clients
        6)    Chat Applications
        9)    Archive Handlers
       10)    Audio Applications
       11)    Other Applications
       12)    Development Environments
       13)    Browser/Web Plugins
       14)    Dotfiles
       15)    Web Links
      ------------------------
        a)    About Manjaro Setup
        q)    Leave Manjaro Setup"
        echo
        echo -en " Choose An Option: "
        read option
        case $option in
          1) showtext ;;
          2) showftptorr ;;
          3) downmanage ;;
          4) netmanage ;;
          5) showvpn ;;
          6) showchat ;;
          7) showimg ;;
          8) showvid ;;
          9) showarch ;;
          10) showaudio ;;
          11) showothapps ;;
          12) showdevapps ;;
          13) showwebapps ;;
          14) showdotfiles ;;
          15) showlinks ;;
          a) showabout ;;
          q) manjarosetupexit ;;
          *) echo " \"$option\" Is Not A Valid Option"; sleep 1 ;;

esac

##########################################################
#               Fourth Component - The Credits           #
##########################################################

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

  ${b}Description${enda}
  This script is designed to help me, and maybe you, install apps to get my instance of manjaro all setup quickly after a reinstall.

  The script is growing all of the time and will have more apps as I need them.
  "
  echo && echo -en " ${yellow}Press Enter to Return to ROOT Menu${endc}"
  read input
}

# Exit ManjaroSetup
function manjarosetupexit {
  showlogo && echo -e " Thanks for using ${b} ManjaroSetup${enda}."
  echo
  sleep 1
  exit
}

done
# End
