#!/usr/bin/env bash
set -e

clear
mkdir -p ~/Helpers

if [[ $1 == 'hmi' ]]; then
   TARGET=Lighthouse-HMI
   DEVICE=R5F51306
   CODE=45C0C0AC1C1AC2C2AC3C3AC4C4AC5C5A
elif [[ $1 == 'dispenser' ]]; then
   TARGET=Lighthouse-Dispenser
   DEVICE=R5F51306
   CODE=45C0C0AC1C1AC2C2AC3C3AC4C4AC5C5A
elif [[ $1 == 'mainboard' ]]; then
   TARGET=rockhopper
   DEVICE=R5F51308
   CODE=45C0C0AC1C1AC2C2AC3C3AC4C4AC5C5A
elif [[ $1 == 'other' ]]; then
   TARGET=$2
   DEVICE=$3
   CODE=$4
else
   echo
   echo
   echo -e "\033[1m> Unsupported target!!!\033[0m"
   echo
   echo -e "\033[1m> Choose only between: dispenser, hmi, mainboard, other \033[0m"
   echo
   exit 1
fi

echo
echo -e "\033[1m> Erasing $TARGET...\033[0m"
echo

cat << EOF > ~/Helpers/erase.jlink
exec SetRXIDCode = $CODE
r
h
erase
r
exit
EOF

JLinkExe -device $DEVICE -if FINE -speed 1000 -autoconnect 1 -CommandFile ~/Helpers/erase.jlink

echo
echo -e "\033[1m> Erase Completed Successfully\033[0m"
echo

rm -rf ~/Helpers/
