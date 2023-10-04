#!/usr/bin/env bash
set -e

clear
mkdir -p ~/Binaries/Temp
mkdir -p ~/Helpers

if [[ $1 == 'some' ]]; then
   TARGET=Some-Target
   DEVICE=R5F51306
   CODE=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
elif [[ $1 == 'other-random' ]]; then
   TARGET=Other-Random-Target
   DEVICE=R5F51306
   CODE=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
elif [[ $1 == 'random' ]]; then
   TARGET=Random-Target
   DEVICE=R5F51308
   CODE=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
elif [[ $1 == 'some-other' ]]; then
   TARGET=Some-Other-Target
   DEVICE=R5F52317
   CODE=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
elif [[ $1 == 'other' ]]; then
   TARGET=$2
   DEVICE=$3
   CODE=$4
else
   echo
   echo
   echo -e "\033[1m> Unsupported target!!!\033[0m"
   echo
   echo -e "\033[1m> Choose only between: some, other-random, random, some-other, other \033[0m"
   echo
   exit 1
fi

echo
echo -e "\033[1m> Uploading $TARGET...\033[0m"
echo -e "\033[1m> File: \033[0m" ~/Binaries/$TARGET*
echo

cp ~/Binaries/$TARGET*.mot ~/Binaries/Temp/temp.mot
cd ~

cat << EOF > ~/Helpers/upload.jlink
exec SetRXIDCode = $CODE
r
h
loadfile Binaries/Temp/temp.mot
r
exit
EOF

JLinkExe -device $DEVICE -if FINE -speed 1000 -autoconnect 1 -CommandFile ~/Helpers/upload.jlink
rm -rf ~/Binaries/Temp

echo
echo -e "\033[1m> Upload Completed Successfully\033[0m"
echo

rm -rf ~/Helpers/
