#!/bin/sh
set -e

clear

mkdir -p ~/Binaries
mkdir -p ~/Binaries/Temp
cp -r Binaries ~/

echo
echo
echo -e "\033[1m> Setup!!! \033[0m"
echo
echo

sudo cp info.sh /usr/local/bin/info
sudo chmod +x /usr/local/bin/info

sudo cp power.sh /usr/local/bin/power
sudo chmod +x /usr/local/bin/power

sudo cp erase.sh /usr/local/bin/erase
sudo chmod +x /usr/local/bin/erase

sudo cp upload.sh /usr/local/bin/upload
sudo chmod +x /usr/local/bin/upload

echo
echo -e "\033[1m> Setup Completed Successfully\033[0m"
echo
