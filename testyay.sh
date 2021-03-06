  echo -e " Currently installing ${b}Google Chrome${enda}"
  echo -e "${bu}Chrome is a freeware web browser developed by Google."
  echo && echo -en " ${y}Press enter to continue...${endc}"
  read input
  echo -e " Installing ${b}Chrome${endc}"
  su $USER
  yay -S google-chrome
  echo && echo -e "${b}${enda} was successfully installed."
  echo -en " ${y}Press Enter to return to menu${endc}"
  echo
