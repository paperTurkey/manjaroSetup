#!/bin/bash

sudo rm /usr/bin/ManjaroSetup
echo -e "cleaned up /usr/bin/ManjaroSetup."
echo -e "restarting the install"
sudo ./manjaroSetup.sh
