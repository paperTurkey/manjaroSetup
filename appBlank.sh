# app blank
echo
echo -e " Currently installing ${b}${enda}"
echo -e "${bu} is a "
echo && echo -en " ${y}Press enter to continue...${endc}"
read input
echo -e " Installing ${b}${endc}"
pacman -S --noconfirm
echo && echo -e "${b}${enda} was successfully installed."
echo -en " ${y}Press Enter to return to menu${endc}"
echo
read input


# app menu blank
showlogo
echo -e " ${b}[ ]${enda}"
echo -e "Make a choice:
          1.
          2.
          3.
          ----------------------
          q. Return to ROOT Menu"
echo -en " Choose an option: "
read option
case $option in
  1) ;;
  2) ;;
  3) ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not a Valid Option"; sleep 1; downmanage ;;
