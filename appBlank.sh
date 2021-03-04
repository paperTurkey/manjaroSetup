echo
echo -e " Currently installing ${b}${enda}"
echo -e "${bu} is a "
echo && echo -en " ${y}Press enter to continue...${endc}"
read input
echo -e " Installing ${b}${endc}"
pacman -S --noconfirm
echo && echo -e "${b}${enda} "
echo -en " ${y}Press Enter to return to menu${endc}"
echo
read input
